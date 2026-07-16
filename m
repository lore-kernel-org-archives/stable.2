Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDFE324B2C;
	Thu, 16 Jul 2026 14:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213932; cv=none; b=M3RxneinyI6YyngxpbQvRHqu4jiiGUvwA3uQAnifu4vf+LOSlDQXXLTZB0Dmqh/JByJsnbTTKhPNBosrUKgz2YqH0z/+w7g60QNg8tqmE002ScjQcJKl7nZBeHf0/nBXOBtz81/JmDM6tlKFyuNIf+aGW53O12nXvw8MGaddwM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213932; c=relaxed/simple;
	bh=YYT94eJBx3or6U8w7zZRBnkxg9IlWo3HIkdU+D5Oy64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9epjq9rS/Q0rFulbZE+nkpZ82G8A/RdGxy5f8xV9E//1v0Zv6CJJ87bAWP0Ox7yhBwoFDxm5wK4XAt7qQqxZrRBMQnlageuNWisBulrPNfeETDZNiszu5BrBJsVQygM0IDG7NUtkpfuuJohpBw01Pz/zwIw+elnaiXafkt6MFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDzjhTht; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDzjhTht"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CD61F000E9;
	Thu, 16 Jul 2026 14:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784213930;
	bh=hdWH9w598lMkzkulklCO/KS15UEmhMIp1D6LdV+8aeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BDzjhThtK1/9Sqzw/sdNqD/B1Xkb00unxro5KoRg3X9wygMUVkVSeGfMPiriSa+Xr
	 WUoQzgipCowDu/JyYB3i9nkUxvJmWi926tiEq7XVhtR0DNSqyrIrSUYid8to2wM3C4
	 4eza1I9zEHFFvbaIci2qJHiSZk0nnnBT4k7gjNUmXYH4VmBDq795C0ajBWrn6IAC8v
	 42HP1J036cbGORM+DnOx4FYMdUn8NlBuR1VGpnjXloek7ojMGZyYICPTKcpxjSPnsd
	 mc4Vs3L5iPMKNFAe9zJLZBP94tBsgHrjlXiRZXz5U5eVOZjq9MOOZWl2j9I2TEvQIa
	 7Mw0e9aBcTjvg==
Date: Thu, 16 Jul 2026 15:58:46 +0100
From: Simon Horman <horms@kernel.org>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: David Heidelberg <david@ixit.cz>, oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] nfc: st21nfca: validate ATR_REQ length against the
 received frame
Message-ID: <20260716145846.GM95246@horms.kernel.org>
References: <20260711071301.58071-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260711071301.58071-1-doruk@0sec.ai>

On Sat, Jul 11, 2026 at 09:13:01AM +0200, Doruk Tan Ozturk wrote:
> st21nfca_tm_recv_atr_req() checks that the received ATR_REQ frame is at
> least ST21NFCA_ATR_REQ_MIN_SIZE and that the self-declared atr_req->length
> is at least sizeof(struct st21nfca_atr_req), but never checks that
> atr_req->length does not exceed the actual received length (skb->len).
> 
> st21nfca_tm_send_atr_res() then trusts the declared length:
> 
> 	gb_len = atr_req->length - sizeof(struct st21nfca_atr_req);
> 	...
> 	memcpy(atr_res->gbi, atr_req->gbi, gb_len);
> 
> so an RF peer that sends a short frame but sets atr_req->length larger
> than the frame makes gb_len exceed the general bytes actually present,
> and the memcpy reads out of bounds past the received skb. Those bytes are
> placed in the ATR_RES and sent back to the peer (kernel-memory disclosure
> to a proximity attacker); a larger declared length is an out-of-bounds
> read (DoS).
> 
> Reject frames whose declared length exceeds the received length. The
> adjacent nfc_tm_activated() path in the same function already derives its
> general-bytes length from skb->len rather than the declared field.
> 
> Found by 0sec (https://0sec.ai) using automated source analysis; the
> missing bound is evident from source. Compile-tested.
> 
> Fixes: 1892bf844ea0 ("NFC: st21nfca: Adding P2P support to st21nfca in Initiator & Target mode")
> Cc: stable@vger.kernel.org
> Assisted-by: 0sec:claude-opus-4-8
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>

Reviewed-by: Simon Horman <horms@kernel.org>

FTR, the AI-generated review of this patch on sashiko.dev does seem to
raise legitimate pre-existing issues which relate closely to this patch.
But I think they can be treated as potential follow-up rather than impeding
progress of this patch.
