Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07523E866B
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783942901; cv=none; b=aOSX9XCB50avj2pRZ9TFobQvrJYwEE8qwkf3QgT/PNc+mBheY1H1nm40RfWl3F77ykkRQQ1+U8eoJ0E2fVjVu5RzjKiRyRRPlWM7VNAItoLS41qF2AfyUGWXPgMDU5DC3F5jrgeELI/4zCCB65VgAC/79knNpYa8x3sp53Qmzl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783942901; c=relaxed/simple;
	bh=Aptw9BP0Lcs+YvRZ76v7E7JJ6QVmrbM+EF/a62t9ku8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=WkPtJJ+som9gYw/2ZuTjxnyZjtMOrMYxSlzviWC8Cztm8bICOE2qgdfqPHoi93X3FWgEeFh9QDsZNa+9qxrBHDctM93tHz5CAr8xXaPiUxvCajTp2NQyHs4Wg+oyXF0+zOyVJiYoz1x/5Eci6kfv7pnUWYEBesCXjoWcuakrr8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/ZVIj5I; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/ZVIj5I"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c88a4d79ba5so1975469a12.2
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 04:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783942899; x=1784547699; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Aptw9BP0Lcs+YvRZ76v7E7JJ6QVmrbM+EF/a62t9ku8=;
        b=M/ZVIj5I2DEMooJOdTgubeU0ynI/jepSKCRnDmbhlA6yL5AGT36PIAo42kxHNIqPXs
         PGNxMcvByQtr0J+8Wzh/UOwxEQK2MB93Ut58b2mdx/toKBVNd+FF3Wvo2lhnGDCNSX25
         mALMfPD1jGZ3TaFC9KkM9QVOLnqWeV3Wd59fhKaObMiZd5ZT1XC1rGy/lezLkdXwgY+7
         ig8qDhWQK55ZuetFl2YXBvm6ydQBjjmT3u8Yx26qlCpWf1G07k9dVNcXd+ZpHOdP7Pc+
         vhyVxhvA2n2cOrbcfh1aij/Yd4CLQGe39OdWY4lmTRwvgl/3y0VC2X2BWdoEt2iJc5Fe
         U5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783942899; x=1784547699;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Aptw9BP0Lcs+YvRZ76v7E7JJ6QVmrbM+EF/a62t9ku8=;
        b=Hq7fkrhU4Xcx10Sy+RsqpoXTWnfv+4bD2630Qv34vdSJDb0eWYUWgknbGRY4IO46kB
         3rd5v4THq1rWcn0JNwnqdHe2+Y1sU3ac9VQmjtdRX6wFuX4jEcMwYjHWXT0ZO37o1OYf
         ONUCxFSCHoxvoatd8NFVzsQc+UlvOWjvodKidJq1xrHg/6dklqNLjpjNlc8BrePQ6Bdi
         PinMp73WJD37VvpL1Cey4D4KH+rIZaX9QZOng70NcKgSTfOY8TcJsOxeyp8P6+T3O3R9
         26I2wWL/TJDhMzcYs9s+q68xVa2afjYRWJJ0CJ1zACpJWGJPN+SknRwHiE9z8g+NTOY/
         i2Fw==
X-Forwarded-Encrypted: i=1; AHgh+RrSryJ63XhKMm+NI9Yco5IxglUThtGusTdJEhYdSrgyQRcYOjNTxpxOMtAZHjnu+NqBKdDjJtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKrJraxRJv7NzVHo75S6wVQQeQ/RvfXZuGOfCSen8qSrzl6/rZ
	44DfwAg/cH4dQdnWs4hr3G1jgBayIFXklYKsRUbh4zi3TCAdQJcm9ZiQcR91Eg==
X-Gm-Gg: AfdE7ck07WgR5lOzakF98CBtCPJx23z/ZXZixHVnn79gornHg6WzLq2/XxiNLycw7Uj
	5xFBj/oUkqyDhuCIhc5QbBez5FIEqBHrfh9MXnOm6o7xpLT2Frv/OlUOfjkEKoNUPQThI1WWfLv
	Hqbna+p5SCjD7eQeTo3fNuZl68dIVEV7+Rnte12sizCfmH6DZXoljP7V0a6B4pkxx9/r60tNL7r
	moA0KEo9FA7TPNATSBZKcEWrY6dMisMv0uxCh8mStV+RbsggXN9JKJb8Pqv+SfTY4psap1OQ3tP
	lbTfkgFrei9pRDHcKisMiR6Ib3vDzbrdrZIHH5OUKiKqYixmQFbluuKkui4n9wAGFtTJiafesfd
	toGupIKPsBbIl3nPoPksi4W84Qo86XD6//hRbCOEolZujyVTOPFDQd7tgwXWuz0VHwG3rKLFdJ2
	G6MhuwpTAGZPs=
X-Received: by 2002:a05:6a21:486:b0:3c0:9c19:658b with SMTP id adf61e73a8af0-3c110ced356mr9709546637.69.1783942899190;
        Mon, 13 Jul 2026 04:41:39 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118389d9bcsm58974708eec.20.2026.07.13.04.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 04:41:38 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com, hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com, venkat88@linux.ibm.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] powerpc/crash: protect kdump from active watchdogs
In-Reply-To: <a5f57d59-a246-4279-946f-2e41d1b438a7@linux.ibm.com>
Date: Mon, 13 Jul 2026 17:09:18 +0530
Message-ID: <jyqzunix.ritesh.list@gmail.com>
References: <20260713035954.1559605-1-sourabhjain@linux.ibm.com> <mrvvv515.ritesh.list@gmail.com> <91e04278-aa90-4cbc-aeb4-f4663bf1f058@linux.ibm.com> <ldbfv1dl.ritesh.list@gmail.com> <a5f57d59-a246-4279-946f-2e41d1b438a7@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Sourabh Jain <sourabhjain@linux.ibm.com> writes:

>
> Okay, for stable tree inclusion, CCing is enough.

yup, by ccing here means, adding a "Cc: stable@vger.kernel.org" tag to
the commit should do.

-ritesh
