Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C5D551985
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 15:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791991474; cv=none; b=ojrwc1l7RPlG4ee6c8m6V4pfXQsvtcvSyiD7GQcQdO6Tk/sGIxxlMLKmFZ10vCawzzQsRZgp6Y1J7rYSxax2oHTycDbZxGH3RrXODHxQurPpmYi/p9nnFVXKOC2WT7VsYSTab2VLsYIU2K32M2o/OY6qywqizj0zeQL+RpD35Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791991474; c=relaxed/simple;
	bh=j7lxWLDV11oCPAd9zrLwY8YtZWMYkppFEMxTV68KR2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gt1esYviYi6GO7enS3a5qi3jzEMZPWBlLpYxbC1wQUJ+PtnIu2BgQWtSye73oOhtLlCnkRO2KX5bXC0RDUX5Pg2skoOozds1lsA8ZSVPbd5m0YWqy1JOz/CnkoAQ7ASstbfM0AhAO+NFzN2mMeLEiwUFJUHNrTfQESrbFyn6ATg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=DlPjgH+R; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="DlPjgH+R"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ab4178ee33so2396923a91.3
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 08:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791991472; x=1792596272; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X+A8usko4cfoywAC26NwTGT/rqph25xWtjEIyd5GKa0=;
        b=DlPjgH+R4eVy0Q9DUapa12egNiHPhSBPBBtUFEwylIHo2+kQgJZFk8LDZsedaol2Gj
         xbw4MRAClT2NdIJVJEbZHI3at8c0HZzR2hEmvIXuHCRGjaCtalKV57gSfSGQ57MohQMT
         HMb59FqY8lrOqK5rzJEFk8JDpY3tlTV8VxLilPVl0tui3BTW6O6tXTbg0yGrCWHK1s1s
         6NJSJ3TnJkE4CMe0ZBWqNofomfYkNLUzmvWByY5iYwJD+UWtIV+w0A0Z5W4Wxoqsllzv
         fz6QWELI2ZhLUw6DJi1Yi+B9MfaiykbRIqg1nc+heDwrqi5GD1l5p+asIJsefUGOGXie
         WOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791991472; x=1792596272;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X+A8usko4cfoywAC26NwTGT/rqph25xWtjEIyd5GKa0=;
        b=UWQrvVDmhLBvMwKrzhPiVR9NA+eFpeXUuMr12Osh0oPvf5qB+T7Wo2+7zj+/D+KNIX
         wrKSzrs5swPkzdu9GPoAcMtoll+MEyfnK9sOdX+CfpbRI1M3OajtxPj32mAY1RzZdx8E
         6NFsgOm/nIux44TlyCP0KRbZ2l0ssu/928SahabOfusC3PsA+Y1odX0a4/uzyaEW7Cf0
         NS9ZKoyZ+d3Ij1/20fsj0tiVD4tmGjTjdFBID18xmHkGRLjjsbEtwoe3npaFL5+Ef+an
         0/YdRct5rPaxppiWHcAxUGG/zVp74Lpu/gkyfR15kfUMediiSKi+DbX49DCGhSu3h//R
         cv7w==
X-Forwarded-Encrypted: i=1; AKwUvByOx0uma1GcZ/nkSSEb8NGROVxANvdiCvtLwDl2jlIhpPrZdY3tqcmyVPGJTkRe08o3nFR7olc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJS+ZYXSkWjaMapHbhfpzFPX5YSwqZdtzTZfqzwmsFI6rS5XB8N
	XO+M9sZLTxHOjneNgFQ8MbtdlKCJdSYbgTkHIGVH6vyRsegDwtk4Fss8mCfBaWReNGI=
X-Gm-Gg: AYBFou2YeJ2FGcDa0QN7+hqxpYNzBsTnJipBhRWGa2Ed0cW75av8HKV/cW5Qm6vnh+8
	zKFY5/14SV+4sFWWOWy6Xaelgw41aXFNX4Hgik7LAb9Jmdt/8etfVO9HOqYsXQMKt+GH057YGee
	tucZc88cuYt4nsr7C9H6o0WP9GqFbisBjltYvBB99H+o3haKUQLT16DRoip+4LmR9sPHIRqIGuc
	/LoUT1vQ+yuKObJbuLl9hOx95iHAneaWC/jcYtySzNg9+EWjx0hvrM3Za+VutGR2JJnpqr5VHlw
	zrGVyAb27fDLJS5ai1boI+mfX9DLdvmhlTI5/1aCYqFfUlknHVD3+R9tEa5ECn70p+J3LfOSCHx
	oGVYoTAjnzKc4Nsi/98LzO88g9V7y4R1MFevDy3wGAylW9W0i2iQoAiTa62VwYyx6cQkLs+m8Dp
	FtCX8aPSTcr1Idv9wYbSHFy6AEuYh8UNiUQ0iikSQS6pRE3Aa4lwGw5JsnmcNFeSfJDt0ofBjbq
	RTMkEylFsUsV+3ia/cf
X-Received: by 2002:a17:90b:3d82:b0:3a8:f70f:2437 with SMTP id 98e67ed59e1d1-3ab3ab3771fmr11573342a91.50.1791991472168;
        Wed, 14 Oct 2026 08:24:32 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:1c49:61ee:8c8:3f4c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac9373f5c4sm58461a91.3.2026.10.14.08.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 08:24:31 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: Re: [PATCH v4] scsi: mvumi: reject handshake sizes that overflow the list allocations
Date: Thu, 15 Oct 2026 00:24:25 +0900
Message-ID: <20261014152425.3637406-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014134104.3528958-1-yhlee@isslab.korea.ac.kr>
References: <20261014134104.3528958-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Please drop this patch.  It is superseded by

  [PATCH v5 0/6] scsi: mvumi: bound the values the firmware supplies
  <20261014151914.3632701-1-yhlee@isslab.korea.ac.kr>
  https://lore.kernel.org/linux-scsi/20261014151914.3632701-1-yhlee@isslab.korea.ac.kr/

where it is 4/6, with one addition: it also rejects an entry size too small
to hold the frames the driver puts in the entry.
mvumi_internal_cmd_sgl() writes one scatter-gather element at payload[0]
whatever host->sg_tablesize says, and the max_sg subtraction in
mvumi_io_attach() wraps when ib_max_size is below
sizeof(struct mvumi_msg_frame), so the lower bound was missing from this
version.

The series also folds in the two-patch length series I posted separately
and adds three more bounds from a full pass over the driver.
