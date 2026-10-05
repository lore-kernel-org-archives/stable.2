Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEF124501D;
	Mon,  5 Oct 2026 05:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791179342; cv=none; b=b8gj/66nSzPmjjNpeom2sY6r6g2s3mrmDyATSAzi+VXINm7Lkkx90jnU/gnxPeFIGLOJnfa+FK1iE9JhJ2PIFIWvOvWmZoj8A1YrR6XoXIPPM1dmjkvufed+PR5JXlvOGrYT+8G59qIA0sAcEM0WLU07I5JgVL8HKWqIRBRLUwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791179342; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qUkWTZwYBl3vtE3SLou2nIZN+beDBPKgE/3Rd8PZnjHQcHFKLOWE6OXuKWLvkMEnrfdC/pVLGgg5OcS16TAqnd8l5Hyw/kXTpMEQ+LfTQiOGPKPK7yIW5LKnOHC6okDDEtR9zk0vVNj4MclfTXfUIvoL7rxCs3g/KbcrLpjHJTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSsCpoEj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSsCpoEj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D441F000FF;
	Mon,  5 Oct 2026 05:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791179341;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YSsCpoEj/jiGFhsdn1JfX+rTrNdM4VbToR9lCDxmkOXYfv5Ych28ABJJZpZkJQkIw
	 Uk22HYHdeGt8j/fOcuDVrNrzLDPg2B/WPOX9WjXm28uVVdYmc7yTbCxrjkrlscUXZ3
	 XzsWWECQC7Ok9XY/gM6XzASfWFst5Gh3C93kd0a4zNTRrT134W66ppmfxzkWjTxZPr
	 8784LzDcUmm0QHyxTbzGFGwIqsCfeAUNXBK7hAdilQZcalcWXeMsn++yq5MIkSI+aL
	 sPm+9ESlGviYbijDRLpcnMQSZ5JucJIFuvqbZ1n0C6XgHZ1g/ewVJj7gNMxwkabcTO
	 Oj3OvAW9McUrg==
From: netdev-bot+sinfo@kernel.org
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: maheshb@google.com, willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, peterpenkov96@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, error27@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] tun: fix skb length underflow in NAPI frags path
Date: Mon, 05 Oct 2026 05:48:59 +0000
Message-ID: <179117933970.1402591.17373421517734454461@kernel.org>
In-Reply-To: <20261005054224.4154727-1-harshit.m.mogalapalli@oracle.com>
References: <20261005054224.4154727-1-harshit.m.mogalapalli@oracle.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
