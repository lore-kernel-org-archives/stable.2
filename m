Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76DA369D53
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 20:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791838366; cv=none; b=Qh8Y7G/yrTENRscgM/Lo0PJNOZV6fDxhNa23wD4HDFiar7h0uSypszPXrjFOx7K7FrLdStOOi19+HhPOxj9fECTaFZ29KYRNa4RO8TwUbkbLgsTiiGhDXl0Rgk3rmBR+1k9ks7KeEfP2+lTPCBUgoh9xy63675Vs4zC020u40og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791838366; c=relaxed/simple;
	bh=YeZW5RdTOI04Llt3JVWcDwFcKk7FkOJp4zs3oeAW9uw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=FacYQ/QP2/5kNBwYOhYmo2z38njrZ5HiZEPq2saQqiqzl4MPBW6I2c/qm6jpE1vNWCuIe3S9GiqLwhsa/PRuht0liPnXWxSGceCxD2FgBWiIjmad1tpjSm4yh8wApzYd5UwOoZDg0o+ZLOjbuAroUo7jk3ud6XGoiQHvmBH6tdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=It3wklO/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Eg8DFXqm; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="It3wklO/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Eg8DFXqm"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 125C41D000E0
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 16:52:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 12 Oct 2026 16:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1791838363; x=1791924763; bh=Dl3fdoqXiToQPfsm7pfCuZ1D4o3Ebah/hki
	xHDzwfiw=; b=It3wklO/0p2Yi5TgHsm+QlbrcwOv1q9kCu/HIwiW2+San3fqzYh
	uoxIlHVB5Uyrj087moiPGqyNOi+fFWWdLOl35/PGy/Wo+5d6Luu1GaIWT+Njt3a6
	69Ns0ocIQHDGqGE5BqY8GeOEbUbJhaFi1rLf1bpjkfDswePlNTfdrBie7SWUReU4
	dyvoR2KtF8w9jnKtzcPyYvcp1D8ug+kuejF3V5YI8p2OHg3tY6AngB8IrqhHHDIv
	Urv35k0XoRjoesWv4kxjzISVQ6zMZ0bjNw/i7OETKcBaLgidgLKg7dGyKhZy7pAs
	gnswyQIeQtzFwldjTpkfz0JDRFNsoRVLdBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791838363; x=
	1791924763; bh=Dl3fdoqXiToQPfsm7pfCuZ1D4o3Ebah/hkixHDzwfiw=; b=E
	g8DFXqmnjleXx/UVA9PSE72Dq/r17J/7Ck9LufJTSoFSQ8/SV8jkIu2yVxEg97FR
	hitU/HCUBM6IzkIDVsmQnr7SLHx7C+6xtNeIZT8u5yT360FuT8Zu3fjpAYDC318t
	9ImnMJ7N/eGxbv+f3tbwRkhXstDk2W2Q+3FsoxnD6INoKp/X5hQS1vZyfhV8FxcE
	BFrh0OMGhWHezjKcMvYbQwzOkGxlLNSzPrnTS95leYa8RArTktO7HJI4DEH72+V8
	7Od/shDZp/fy9a9fsOQUagbiFRaigMKv0NMAQVDIlJ0iouCw4XL4XrLop5SNejRb
	jRpmOChwpZ9GCCHT/urMg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791838363; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:KRDSX4x2to6TbQwFqz3JIQYuHaCIBLUZeirunF0CGeDCTgl
	11Tc97pakDhklFZFxni2YfurBRzQevissxD0OjulWa+N+UEjt53fhFe8JYhXKIuh
	evqXKm1sbtD3u66ZYRkTDhgQe6gy10OBW0sqZnhO5iAtvJg6uyHViZXL05YKFrwX
	4ZCWCDa0n4RdQ2eWT9pEiuwyQ3AE8YNrQC5YUaGIDegvZUvz8gxwzA6Ov1I3IMG6
	hrXUDCN0YSiaMjbCIOBUSqlifHcbFqEQ8P1KU1j1t7qhpP7JzAygmyX+cL3uTjdK
	9lzuC144ITtZURLFTiVUIJkGGBWN8LQCVdk8nwg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,reply-to,
	subject,to;
Message-Instance: m=1; h=sha256:uJg3LtQR/GajkULLSqBKDnkR72NMPM9CcRlRlCv4gs4=:YeZW5RdTOI04Llt3JVWcDwFcKk7FkOJp4zs3oeAW9uw=;
X-ME-Sender: <xms:m0jNaiu2U8MYBwsgvQAMhm0GQNcLJFG1DjnL8ITZse-h3SHr_rhmAA>
    <xme:m0jNakAZvxFhryBWQLMQlTkvvy7Rix51cpf1IjaLHgiTh8BC3na1qOrsJr3pf6QYQ
    nkwBRouCMo7j0_ec4NjDUjFKx9Ox5I676ZfQ1hjjkVrF23sT_LX>
X-ME-Received: <xmr:m0jNaiN5s3lbeOjdMN6HxfysRg9UxVr1c-zsNvdovc6MXt_Y_DDMbS-SYQvhXsrdIV08GqqcdYUgiQi3vZWjTSmPHUsjZyQ>
X-ME-Proxy-Cause: dmFkZTGNhItM67zy+AiIQUxlMawBhmhz0ieWWNQnE27OecISIphkqfNVxxBQr51hIKsmg4
    8LBg6rs7vBjcmjivxwMhUHUcaHq7EKvbXA28O2YdtvfvrxQaMafHJFvxUw1DmFfqaEHSJ4
    fwFl1a9OwP4fhQwndimq80hUPXBchLn2RxYb9Du7vjIXAjzilxr2H76nlMfXquGkQk0Xnc
    sz0C6KQ2U7DNZgnqUzqfBXb5ckwuKH9YTD+C7RWmkkZ40sG806k1fIyULQmqz9dSYi87Fh
    MwacAYE/I4gV9h57Nk+xYFrPNofYXuABAfbechWbmPKDyEkRcGlJK8sPw6kKWARZ36wQT1
    Y7nHdVDK1bCgm1QqIj+hu29ssBs4tmDwSCf6NVJUm1uKcbKL0A9hl8p6l/NdUDuH0+2cOT
    xB9VY/XiCE/+oauZdg27NZR3Zq+YqkLvRIXUEBeJ87FQF/GLnkz/LV6zgl0T/UV4AVJvcC
    m/zynZ6EQHPeVSPeY7+xpU9etgWMdQbU9Wdwqk3Py3A8bT9VEaelYhaF+jWonmGIYtf+2K
    dd8OvyBH8vSLd/svPNRgsfABQ84LwSHwF2LpeguvHQ7qX834zB74GNgOQjtFnhs0O2bKPN
    6NpAn+vAQ6AWUn7sBGOMxIQ0ecanC7nEsIobpyr/FvqFp936xjdHzmrcXdpQ
X-ME-Proxy: <xmx:m0jNakAH-UYCr3a57pRAI7fN2IkKWQrwSAgAcOSU5mcOtGqeifgQkQ>
    <xmx:m0jNaj5uqX_smW_SyvZ3vabCelpjJpb_W1TgUHhk7zf5EiuywptrwA>
    <xmx:m0jNau4bWtL1n25cAn_reR0CFPj_AIkE5dxzNTFyH8dDlBlau91i-w>
    <xmx:m0jNalQhnjzzVpIvNVGRItVsehHk8z1g9uloHSAMyyfccBKS8MH1aw>
    <xmx:m0jNav1hfyOVfn7K3yOKmdRwLReBBo8sSsitDuVCb2zZG8G6ruWrnhSv>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 16:52:40 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, "Chris Mason" <mason@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 "Josef Bacik" <josef@toxicpanda.com>, "Jeff Layton" <jlayton@kernel.org>,
 stable@vger.kernel.org, "Christian Brauner (Amutable)" <brauner@kernel.org>,
 David Howells <dhowells@redhat.com>
Subject:
 Re: [PATCH] namei: test for a negative dentry the way traverse_mounts() does
In-reply-to: <20261012-work-namei-ocreate-v1-1-c7883b17ee28@kernel.org>
References: <20261012-work-namei-ocreate-v1-1-c7883b17ee28@kernel.org>
Date: Tue, 13 Oct 2026 07:52:36 +1100
Message-id: <179183835609.1724252.2051936919228724788@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 12 Oct 2026, Christian Brauner wrote:
> lookup_fast_for_open() only hands an O_CREAT open a cached dentry if
> it's positive. Otherwise the open goes on to lookup_open(), which takes
> the directory lock and creates the file. It tests for that with
> !dentry->d_inode, but traverse_mounts() later decides with the type in
> d_flags. And when a dentry is instantiated __d_set_inode_and_type()
> stores ->d_inode first and only then releases the type into ->d_flags.

This seems fragile to me - not this particular patch, but the general
practice of testing for a dentry being positive/negative.

We have d_is_negative() and d_really_is_negative() and ->d_inode == NULL
and no (for me) clarity on when which should be used.

I would like to discard d_really_is_negative(), d_really_is_positive(),
d_inode(), d_backing_inode() and possibly d_inode_rcu().

Then document when d_is_negative() either should not be used, or must be
used.  I cannot immediately see that it would ever be preferable to test
->d_inode directly, but there could certainly be a case for
   inode = READ_ONCE(d->d_inode);
   if (inode) ...

Do others have thoughts on this?

Thanks,
NeilBrown
