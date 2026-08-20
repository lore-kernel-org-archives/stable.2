Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15AA5CDF1
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 00:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787187469; cv=none; b=Kir7yLhO3nLgwloWFEXJxYwZLglciRGfPA32+aqGJYvqpWg6TObBry6SDWQudVXY5JjlXlBWCQ4i6VkkkrooPznI3cj8v3ZACjs/kKCuNRhgVuZrmoWGyef9OhDw3s3CB/Vn/OYqgZSQitkZwb4kpFKE6CYKZqBF47Gg+ZejiEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787187469; c=relaxed/simple;
	bh=f1gTDTn04xgBULfPAqs1+jut3p06CVvDRSRfJVLfUC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICene/gzZZQkN/Wo1MPvg+fI81XtQcOCiCWc04CCqxWBIQhyOYeSicqExLHp55aO6klPz2tgf381xEHZUt2Vn5sqrLLmvm+APP7JsscR70W4dt19ECWWZP/rabr+UYgiGTTvcdiNXSaUVGSYzp62Ha7YxLwopVVdzzzTQFiUyas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=T4G509fk; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="T4G509fk"
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=T4G509fk;
	dkim-atps=neutral
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id E44251F0
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 09:57:40 +0900 (JST)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ce7dff6253so4282135ad.1
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 17:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1787187460; x=1787792260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xZ6vy4VTfKURcQxXwGAZYevGuvbsABfheCK7MjM4YOw=;
        b=T4G509fkE3Ig6taijHKLmoxfWe+5DNhGSe1WWZJQGwebkrnkUB4Zlh60Vecj4CxAj5
         HwCao9INLGDWAxaoz2DPA8wtLkAmcOK7XfBZbxK+5Yc7f40hsp7Vr65xzeqXAH3lR9Rn
         L6+dPiwIvkkOLC8WFe0hg86HF6/csaGPa68qsSRWlIxxOPyITTnhrarGzmzxwRNidbpy
         o0jMVS/+G7SPktu8o/PksIRnC+rLH64LipbJGj0PCjvI0HH+37XhEZmYhcEb6PEAuQJS
         fIziLwmua25RkPml7CIT9/OpyHAiPBgJcMnpyLY/ERxyqprrGn/GrD1jV6xviieDabw3
         DC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787187460; x=1787792260;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xZ6vy4VTfKURcQxXwGAZYevGuvbsABfheCK7MjM4YOw=;
        b=IWOJ/hYPejpo8oLHe2U3pqqvu7zVaVm5H7/GWWXn5juKuOPZcFH98GH2Qpgi1MetxJ
         p/cjLmmVpS6HD/n6iK9gksokAW+Dt6eNU+P7rLUtYkjWF7CxLJzxNCN9hOnrq68xMghu
         S9K2mf1iaR/xVGCdGmFQ9YWAWwJKGX7AiqZ9tQUQzLZoaZUsWRR+MUI3W0L3YhbBTpr1
         5apuIMu2xV3hMIGHalW8JYlTgFufM9edOHJKsTv3D3BRyQZRv9lcSt0bMW5UvoTedwKh
         DFk4hrVRbzz+Y32uwKR3e05JWDe/agn2DiMKqGtUzRdGTnckoI+TbVZjZP9zgsLIG+6a
         YAaw==
X-Gm-Message-State: AFuF++mTyHXERFTg3Mw//GZ2IzRByrGufdtEXKdgM0gSLGZCOH28do3r
	FHc9gUYAfGNFwcxsrY8x+JYmdroIcD/8WJPk4oP4Cz+FgW/UIJh181FhDd4conjWO8ZMRfk2NND
	gzhtmB1MmuiSpLnmRv0tBUOkGR2utGGJLI4TI9kHrIxQMIikywIYtwvw9Qh0=
X-Gm-Gg: AR+sD13mTNls/6021brP3xPGVf7G4FcXz7SE3dKY/AJCx/WeTr49Nv6DudBF5dnagnu
	GU6dn9wd+quasqNTd4+IaILYKI0/NFtpTIpCg5NbXjMShMnvs/nX8vxSyA5GOywTbnvspsy3JEl
	PDtLpeRAn4zn3RiBa3KgEL28yjiH1vdsq9+dDivaxqtiR3SxNJafNsSu/Hn5kLra45qcFKfgROc
	ItgPViRR5YVmufisgFR3iPmqc2FvFJnhSFrZs4IT5M/RtEYZLfE9W8LD5H4ahNeemRpTBRryjwB
	/cfAUTkteQv2QS2fea1jLoNnpBMBrLIDyFGxpABk095U1Eb1US9WzTbxr1qu+XybhnnkWcRCuW5
	nkjaYJottMa8uqsmeOHVdIwHWxTz8TK2VfCIfbpmJEXMfzHse
X-Received: by 2002:a17:902:c944:b0:2d2:72b6:556b with SMTP id d9443c01a7336-2d61a1a54f5mr33599495ad.13.1787187459829;
        Wed, 19 Aug 2026 17:57:39 -0700 (PDT)
X-Received: by 2002:a17:902:c944:b0:2d2:72b6:556b with SMTP id d9443c01a7336-2d61a1a54f5mr33599065ad.13.1787187459368;
        Wed, 19 Aug 2026 17:57:39 -0700 (PDT)
Received: from localhost (sodcd-04p2-40.ppp11.odn.ad.jp. [203.139.65.40])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2d62d588035sm499445ad.23.2026.08.19.17.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 17:57:38 -0700 (PDT)
Date: Thu, 20 Aug 2026 09:57:27 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Richard Weinberger <richard@nod.at>
Cc: stable <stable@vger.kernel.org>, chengzhihao1 <chengzhihao1@huawei.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-mtd <linux-mtd@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Cheng Ming Lin <chengminglin@mxic.com.tw>,
	Liyuan Pang <pangliyuan1@huawei.com>
Subject: Re: [PATCH 0/2] Backport fixes for UBI
Message-ID: <aoZQ90HBGlM-SL8K@atmark-techno.com>
References: <20260818-ubi-backports-v1-0-324d6816d2ae@atmark-techno.com>
 <1200997805.161072.1787136508436.JavaMail.zimbra@nod.at>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1200997805.161072.1787136508436.JavaMail.zimbra@nod.at>

Richard Weinberger wrote on Wed, Aug 19, 2026 at 12:48:28PM +0200:
> While porting these back is not wrong, I have a hard time to see how the
> current stables rules apply here.

Thank you for looking into this!

I'm honestly fuzzy on stable backport "rules", but in practice I see all
sort of things get in (admitely sometimes new features/refactor just
because it makes an actual fix easier to backport, but also quite a few
leaks on failures like the second patch and other general improvements),
so after noticing someone else submitted 6.12 contiguous read
improvements recently[1] so I assumed such backports would be welcome...
But ultimately I think it's up to you, so happy to see the patches
dropped if you prefer.

[1] https://lore.kernel.org/r/20260811161342.533280-1-frieder@fris.de

> "mtd: ubi: skip programming unused bits in ubi headers" does not fix anything.
> It's a pure optimization for future flashes, UBI worked since ever without this
> change.

I might have misunderstood something about this patch, but while UBI
works fine I believe this would increase the longevity of more than just
"future flashes"

I've burned out 2 times 1MB (4 erase blocks) from the NAND I have on
hand (winbond W25N04LW) using either random data + erase (nandtest) or a
patched version writing zeroes + erase, and writing many zeroes failed
the erase blocks about 40-50% faster (85 thousands cycles vs 132
thousands until the first erase failure, 121/175 until erase stopped
working with many retries)

This obviously is a tiny sample size and not concrete proof, and this
patch won't have such a big impact because the area is small, but I
believe this patch will still improve the endurance a tiny bit for at
least our model, which was the motivation for me to pick this up.

Of course, there's also a chance that something breaks from it so I
can perfectly understand if you prefer not to backport it; you're in a
much better place than me to draw the line.


Thanks,
-- 
Dominique Martinet | Asmadeus
