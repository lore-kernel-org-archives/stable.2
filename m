Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.82.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819551;
	b=bjol7LFJjlEncdaTbyflehW17LqlE1ngIiNTrny8gpQ3py1tqiHs2F873x25gVnTAyJl
	 OCbCjogvrFhilzQ4hKftNOjNDO6VEig7TUhkfTSKQcCeKdQrl2LEKmwRK1fW5hvyZ0MLa
	 scO7kM+4aioHLG0WOLOLrpN2KQSe3MMw47Ag9bNsMXlDa3pS9Vk/MediAfAzBkhPn3QoN
	 HxPXfF1Z5k4uXuaM5D7GFfXEx7EHWxPvr7XxBN7jQYgyHJJ/nKRWJj57aqBLVHzhHT16O
	 WIQNmQ8o7qLPrtmoaPH40XKt6v0w3eikU/eeV82HZ45h7CooTkC9e1CmgCtigLJf4/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819551;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=fOBMGQim/n0DIvZol9w5A8rbF8AXfuTYBk54hrONqJU=;
	b=34qbZEL+rbL5B6zmLucHZHu2wdny6BPzePRQ46pulyOR7EKkq/SwX1vknW+gJtDnzsnQ
	 z2qZdInyMNXnkLlFpF1tVksps7EDpHaZnaKw++btXxdfRivvY7F55tfjc1i5j8ys9diO0
	 I+hOIn50XXm3vJaEu8bSWOCWFqvDmoT3pkxsj2bKHVPO9Vc/W3hR2DlnD2cYpVVgEOeg/
	 uDIpVlmiDmpkw7dT0yTKlS+2i2XPhSnxHNP3sl1FV9YjhiS/rbsUUiU0B99iaN/u5wz3E
	 Ht8OaqEPiY9NMw1pgYIFK8yctnEe0hKE5ElT8zqHgix2TzHbUHjNQ6B+oW42oci7jvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samba.org;
	spf=pass smtp.mailfrom=samba.org;
	dkim=pass header.d=samba.org header.i=@samba.org header.a=rsa-sha256 header.s=42 header.b=F+LkGch5;
	arc=none smtp.remote-ip=144.76.82.148
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.3 with cipher TLS_CHACHA20_POLY1305_SHA256 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BE7606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2BE7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key, unprotected) header.d=samba.org header.i=@samba.org header.a=rsa-sha256 header.s=42 header.b=F+LkGch5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=fOBMGQim/n0DIvZol9w5A8rbF8AXfuTYBk54hrONqJU=; b=F+LkGch5E1r0gCqff9BTAQJN4R
	iEcfoO130Hg68nmRkLepQDHuSoJ88ysY4vgVTcxd6e4VPHhUM8cwo/MXi87cGSs9c1oRX9QtQB2IR
	Y2lqLVSlEE9kll5C95FisXfNbQl+b7qwMK5VvIs9sAboaAxOn2yHhV3ftZcjDdEdIk3ZBP9inL7uR
	8WxZdAeL4L/ZmYCh74Jm1UPLNirf6IInPhS5fLePmuLSQvv09ncgJPwTB4dK3R7OsJDTNk3yBqfrp
	ULS4I0UJLfY7lM/PNSR81qwQzDjbB+o23aq1+t288HTgHDhHCqsdtSRIVne0BfBCepY882TO3r/ku
	D33yBmxHeyCuJnJUSiN+G1A1wwE63VC+rXGB19HdH0K166aylevRoRu8CNG3BoONobDYZNUfqHxPW
	6m3Cf2XMzedZLERMmBQ2CMr9sOkyaHeVeRWLyDU9LwJwbWd/B+YQRfNrYeMKl5054FLM9PcSK0GlR
	jylXcZTYs6KtzQMi9c7gJUu9;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1xOgPG-00000008Iyp-2Vjf;
	Wed, 04 Nov 2026 19:12:22 +0000
Message-ID: <456026fe-5cf5-4a35-bf82-75d5ed652846@samba.org>
Date: Wed, 4 Nov 2026 20:12:22 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] smb: smbdirect: fix buffer length
 underflow in RDMA transfers" failed to apply to 6.18-stable tree
To: gregkh@linuxfoundation.org, linkinjeon@kernel.org
Cc: stable@vger.kernel.org
References: <2026110436-thee-asleep-2059@gregkh>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <2026110436-thee-asleep-2059@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 04.11.26 um 19:29 schrieb gregkh@linuxfoundation.org:
> 
> The patch below does not apply to the 6.18-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
> git checkout FETCH_HEAD
> git cherry-pick -x 7193241a49c958782ba4b8df06da3734d1e317d2
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110436-thee-asleep-2059@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'
> 
> Possible dependencies:
> 
> 
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
>  From 7193241a49c958782ba4b8df06da3734d1e317d2 Mon Sep 17 00:00:00 2001
> From: Stefan Metzmacher <metze@samba.org>
> Date: Fri, 23 Oct 2026 19:26:09 +0900
> Subject: [PATCH] smb: smbdirect: fix buffer length underflow in RDMA transfers
> 
> When a remote buffer descriptor is larger than the remaining local
> buffer, smbdirect_connection_rdma_xmit() clamps its length and sets
> buf_len to zero. The common accounting code then subtracts the clamped
> length from buf_len, causing it to underflow. If another descriptor
> follows, the loop processes it with a wrapped remaining length and
> includes memory beyond the local buffer in the RDMA transfer.
> 
> A client can trigger an out-of-bounds kernel write with an SMB WRITE
> request, or an out-of-bounds kernel read with an SMB READ request, by
> supplying multiple RDMA buffer descriptors with an oversized descriptor
> before the last one.
> 
> Remove the premature assignment to buf_len. Subtracting the clamped length
> already consumes the remaining buffer, so the next iteration stops and
> only descriptors within the local buffer are used to build work requests.
> 
> Fixes: e628bf939aaf ("ksmbd: reduce descriptor size if remaining bytes is less than request size")
> Cc: stable@vger.kernel.org
> Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-33549
> Signed-off-by: Stefan Metzmacher <metze@samba.org>
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> 
> diff --git a/fs/smb/smbdirect/rw.c b/fs/smb/smbdirect/rw.c
> index 6fe38042cfb9..cb142c3c50b2 100644
> --- a/fs/smb/smbdirect/rw.c
> +++ b/fs/smb/smbdirect/rw.c
> @@ -143,7 +143,6 @@ int smbdirect_connection_rdma_xmit(struct smbdirect_socket *sc,
>   		if (desc_buf_len > buf_len) {
>   			desc_buf_len = buf_len;
>   			desc[i].length = cpu_to_le32(desc_buf_len);
> -			buf_len = 0;
>   		}
>   
>   		credits_needed += smbdirect_connection_calc_rw_credits(sc,

In older releases this is smb_direct_rdma_xmit() in fs/smb/server/transport_rdma.c

I hope that helps.

metze
