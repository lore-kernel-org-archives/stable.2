Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B906C4FC8C9
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 17:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788543476; cv=none; b=ho9s/GTwIBFRN1mUnZYC9zwjGYyiIG86sKKIwLeTwTpAVzbBiMWope8ZeZkHs2AwnL2+4ASvwTNYiwjh5IE2uT6ZdJdfWTdK8NDuSl7Hl6WGpl3aQinG0nJHh6G0J3Z9dxHp6IPxtAU55rVhOwZpT8RIrOrCZk3f703d94OABao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788543476; c=relaxed/simple;
	bh=ZpZ45xiAlB+4IooyikvfI6oO0AW6kFrfdX8SmCt6Fsg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hBefWXYe9edPUOZPmOMgD7FNW+ccchkrHQLMgwiQvXMdlYHdqo55YtPCQunHK/SwYMOAncZHc06BULgVPwjSVoVnsz7GYky/7EC2QRpdXWyiT8EyfhrSMJViYtKIiRVDPmSIZt8UMu0YB20M7U71nc6dLrAAQXQlAgBMf4kntvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f/ZPwRO7; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f/ZPwRO7"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id F14521A19B2;
	Fri,  4 Sep 2026 17:37:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C2D4C6057F;
	Fri,  4 Sep 2026 17:37:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 16DB811C78705;
	Fri,  4 Sep 2026 19:37:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788543466; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=NGCtegBMvxhNV72n4BBpE6YScdV3H5CF5sxKQIzh0Ns=;
	b=f/ZPwRO7/I98nP+2Y3r7GcCxegsAiq2CPVsDw6AWSZ4bOAkfqTNfEq7YMLZWuTGAwzdM0l
	0o3SKr06fPLG7rC6Np8Pa4qyAGdG7QnpxWUP3IiYlmoEF7ywWc+YVbycvBFsi3e4xuEwY+
	Cl/saTLeRbixzd5XnGjIsfvpaEIiq2RESr6kPYe0Cdh62+mVl0BxVb3eEHMmpvZeFdq+6C
	H0ge0sDfjLMHHcF7t0YcuC2osRS0yhzGOw/HoupNYP2+6i9nxdZayfCne8GglwvEzUNTvg
	MRjBP/NLNXyw+XYCGtJsBsYUn8TdVzAynGznF/HyL/4edq16WpZERk8JicYC5g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: joern@lazybastard.org, richard@nod.at, vigneshr@ti.com, 
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Pei Xiao <xiaopei01@kylinos.cn>
Cc: syzbot+b320a4d5f65a61dbbf89@syzkaller.appspotmail.com, 
 =?utf-8?q?J=C3=B6rn_Engel?= <joern@barelysecure.org>, 
 stable@vger.kernel.org
In-Reply-To: <25ec7ba58facdf29b42ca43dcf11cd98e2089a5f.1786589041.git.xiaopei01@kylinos.cn>
References: <25ec7ba58facdf29b42ca43dcf11cd98e2089a5f.1786589041.git.xiaopei01@kylinos.cn>
Subject: Re: [PATCH v3] mtd: block2mtd: Fix divide error when erase_size is
 zero
Message-Id: <178854346368.1467647.15981574582759186211.b4-ty@bootlin.com>
Date: Fri, 04 Sep 2026 19:37:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 13 Aug 2026 10:48:12 +0800, Pei Xiao wrote:
> The erase size is parsed from the "block2mtd" module parameter and can
> be set to zero. add_device() then evaluates
> 
>         if (size % erase_size)
> 
> with a zero divisor, which triggers a divide error:
> 
> [...]

Applied to mtd/fixes, thanks!

[1/1] mtd: block2mtd: Fix divide error when erase_size is zero
      commit: b5965c4221165045e19736794ca5f48ae3d67142

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

