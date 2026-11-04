Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=79.135.107.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793809097;
	b=GFhfw76lploBzxQqjS2u02p5SS1ItIVPTXdndq4I4GzshtnZ3RYjZi1kmyXiBimvX8jq
	 yI3oeU53LuUG7ddIMUZMYCAzrj2MXP+PscLZzvx2P0+IXawlLFWAU9c7Rp5Ic23ybsm0w
	 p93ko2v/gGHps76M4eqruS4ujywVapofFlM2+DLKHL67sh7UNxrLO1ZXbUashKbKJe7Kf
	 1nO6GE8ygU6AxcKjOgj6NvVgEVFmIGI9xE9sYGoh6pD0FIeLEfoBZdwotaEs7R52HYR2o
	 e4NoXRoG8mVIK5lzkNOPIU7PaTUe1rg5AjBfPFTCznO1ujz+ejP5F9mPV61vuJlRkgA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809097;
	h=DMARC-Filter:DKIM-Signature:Date:Subject:In-Reply-To:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:From:To:Cc:Message-ID:
	 References:X-SimpleLogin-Type:X-SimpleLogin-EmailLog-ID:
	 X-SimpleLogin-Want-Signing;
	bh=/rQmXVkHiDzs2uGaSf1glcnE9dLrPSRCk+lZ+qfQqGw=;
	b=fbYONeN3dm1aXq9PxmzEs1AF1+01kmUwHXDCTQwWp2YrZPg3lGeg0bMyZHHm4K7wcONX
	 FXgtCV1621DztTuyWRTVOX98+04Z6wQFHKXFpUFYOG2+xh6lTzztDC6S+E6muo1qlFDdx
	 Ha4wgfWtbcvb9Rk8EbwUjU8wY5FD6VJyqHbL1B4su1dLtsc9lG1YB7G4eGSfwNJIx+HX4
	 0T6SeT3peRXY+0jG33t7QuADN1XXHLDsYPt0YcL6ywTnCtNiFCHNrdlEcZ8A9iOT7ZgZO
	 GOhCJnmyZVwBoOeEXWfZ7bByXYRAJTMoeICpQ7PXYLa3dKJXiTDawbZeYGyy8tJk0Cw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=eldare.de;
	spf=pass smtp.mailfrom=eldare.de;
	dkim=pass header.d=eldare.de header.i=@eldare.de header.a=rsa-sha256 header.s=dkim header.b=xSx87DqC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=79.135.107.171
Received: from mail-107171.simplelogin.co (mail-107171.simplelogin.co [79.135.107.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C7B606EEAB
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 16:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6C7B606EEAB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eldare.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eldare.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=eldare.de header.i=@eldare.de header.a=rsa-sha256 header.s=dkim header.b=xSx87DqC
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1793809095;
	cv=none; b=rNhBcnJBGT5vY8TOubhM6rBFm8SpI5iq4ZgabOm1hxruxsHuBUYIyFsZHbdhSEN0sz6AKzcuEPYF4UAUqOUHEMnhUjNAP17OBPueumFM/lgP/iLKS4rj3VI4+WSH1jk1+eEWubTiLRjNG82mCv2Tsyh9doGyea56QPc8FK63GudWo75yEnMgrXWg9ttlllMsIyqkbr1NDvGqi3/0Xn4R+Ff8cxNTc4zEJWy1C3Hdx4RLBOIh72mWpW6ntFss+jv49g/1v6Oa0QlEy7E5aRM1/sqV+Q/3AJleRygPu87il5hybWx/loqfJSbU1DllVwgs40HM6hCDIVjmSR6mQp76SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1793809095; c=relaxed/simple;
	bh=/rQmXVkHiDzs2uGaSf1glcnE9dLrPSRCk+lZ+qfQqGw=;
	h=Date:Subject:In-Reply-To:From:To:Cc:References; b=mdjmSQwQR4rSeVppfo1dQetXWHxhh4XNQGQkQ8UQBQVVGc6mS6EVNj/SzaPXsbyB1MERpuLubET4XK2g09jyD3mCSLz4I46IAfLWANB2UAv3BPLErb0AzE7IFqrqN56bvCU1fSIYfP2UhhHBFVq0zOoYtzSrj/ijnZ6Qrc2poG3AHovfouG4NMKUn8K+BnMB8xrhEwold2IHc/3vVYvZbGHqV2FGAmr1OOBjyC9B88bSEX/8vWjf0SrDWjPDIYiNfwdQbY0rlVaZnr+nKqgZ+0sorfmyl7TkYox4Rdk8r0bTGZUNHI4yXwVfU5BYvDSUvHx1M4XwpsgrGs25P/os1w==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eldare.de; s=dkim;
	t=1793809095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/rQmXVkHiDzs2uGaSf1glcnE9dLrPSRCk+lZ+qfQqGw=;
	b=xSx87DqCQq+Fct0l999tAxbeu/mkF5mEzDxj2RgbXVt2RT84a6q03GkZR80mtxSUGeNhXN
	CDFeabpFPCjfRpci/FftoVLVlcKd5pq8+5K1HQz6ar3BNJs49aJJNw39wCrpiipVod1alh
	KiKGZESQXgxJANgZXScTRCMj6oHeow0=
Date: Wed, 04 Nov 2026 16:18:06 +0000
Subject: Re: [PATCH net v2] vsock/virtio: clear vqs[] to avoid a UAF on a
 failed PM restore
In-Reply-To: <20261030101918-mutt-send-email-mst@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: jrmmhm.kernel@eldare.de
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,Stefan Hajnoczi
 <stefanha@redhat.com>,Bobby Eshleman <bobbyeshleman@meta.com>,Jason Wang
 <jasowangio@gmail.com>,=?utf-8?q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,Xuan Zhuo <xuanzhuo@linux.alibaba.com>,"David S.
 Miller" <davem@davemloft.net>,Eric Dumazet <edumazet@kernel.org>,Jakub
 Kicinski <kuba@kernel.org>,Paolo Abeni <pabeni@redhat.com>,Simon Horman
 <horms@kernel.org>,virtualization@lists.linux.dev,kvm@vger.kernel.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,stable@vger.kernel.org
Message-ID: <179380909424.8.665274581449917096.1746194870@eldare.de>
References: <20261028-vsock-restore-uaf-send-v2-1-675aad6da714@eldare.de>
 <auSZtMqcTz3r1nRk@sgarzare-redhat>
 <20261030101918-mutt-send-email-mst@kernel.org>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 1746194908
X-SimpleLogin-Want-Signing: yes

On Fri, Oct 30, 2026 at 10:21:09AM -0400, Michael S. Tsirkin wrote:
> On Fri, Oct 30, 2026 at 02:51:26PM +0100, Stefano Garzarella wrote:
> > Do we really need to write in a commit message that checkpatch.pl --str=
ict
> > is clean?

No, v3 will drop it.

> Yea please write it yourself and make it concise. My eyes glazed over
> in the 1st paragraph.

Point taken. v3 will have a commit message shorter than the diff.

> > This is already in the commit description, no?

Yes, v3 will have it in the commit message only.

> > I guess this issue could be spread around virtio drivers, so would be n=
ice
> > to add common API in the virtio core to be used in all of them.

Agreed, that would be a good follow-up; this patch stays the minimal fix.

Thanks for the reviews,
Jerome

