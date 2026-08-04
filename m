Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CEE38399C
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 19:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785872915; cv=none; b=DF9wWfG87xx/7c5szj7+86sG42TaYHTqtYheDVmjmqosqusriBS8pJn7zFEtx4eplSZ1O9gF9uvgnDDf7EEkXM1008RRmi5qCPovSl+56DLy4zdc2KSqaKCn/V5Ukw4F/7f25zS4wjMquhE41Pb26fmNaVHJ6WQ979UCLXi4TGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785872915; c=relaxed/simple;
	bh=qIgo+XBtWmR8Ac+Hz/2mv2MTPAM4fPt/Odtuaw6BItQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hEQQwpHrsdntnNve+Dh053DxHkyFoHEMIBCmmvgn4GF8stoxf2o79VcJGfeyHgh7J58VAEU2RBwVA0kELRamwxE+WdRjYtB8WEBF0QN8LJhxcIXhFpWdvLjnyO4yIQz0hqmKK/1SPQuVn9OxG52EWXUeIAHDwPac8gx9dhmvItE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMZZPtsf; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMZZPtsf"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47f84023916so149053f8f.3
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 12:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785872912; x=1786477712; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qIgo+XBtWmR8Ac+Hz/2mv2MTPAM4fPt/Odtuaw6BItQ=;
        b=eMZZPtsfSYgbUi5FkHRivP7cFFldUSU2le2wOQMzBM3ntDEIkx6MTJHR1Fe8ABgo8+
         KXUBDGxjEeeGnX84Is+1m6iIGXAXVG7DswQBpvkPlCK619GA8QZds3I6EnfOvms6LXWc
         UbvCFwJ/l43doosFZBnvLQ/vTtSQAkLPVTcQIgtIKu1HlC97Mql38mC5Xy5hy3XZz4i9
         czfD5S1Ebc77ZyqJQjAwGA/tiBN9fq36VqcjW0aFiCLGSsgkCvmrs/O6GTCy4Qto+FTF
         /HndbsDgBHyoDfNRt4Jx32w4k7jLTmykGEYOJ3GfTCyt6x38HAB6ATivbXJsV+tEEC2+
         4qsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785872912; x=1786477712;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qIgo+XBtWmR8Ac+Hz/2mv2MTPAM4fPt/Odtuaw6BItQ=;
        b=X+hMQR6TF3ElYX20x759/AAITOiV+Xvcc2wgMj+i6qv2X4L59NTcvMt+6nPQnWzzHe
         HYtybp2eZ/2+OC62OWaiOfnGPASLPV72/MAsfimDOYuV/6EEqn9fFg3U+HQcpxGcwWQz
         mxy0WhzI/p7SFdhtoyiuyCjDnBWZ33iGWWjmMMR7LSLa/r+JL7OEHRIsQQR4JWZ2EQyw
         1Yc1X/OEG6THKTT/PFb3YWF2vcdINlVI8IWAKjd1VunpwpzzAbG5oMzZ0CT3TQz0hFtA
         Ta13/KqSYZNPUvIazS+QlrmQfQDT8XuXvddugDTLivQXiL9vT8ciXBTCJ8m1RAoifeTE
         3Drw==
X-Gm-Message-State: AOJu0YwIsfEsukXT7JG9UVy/oXXKBAjz/L5lTf8BQ2FynmkZtGivU/GG
	UtQErtlr/9rv9sx4x9fbmzD+7Xp18DGrqSzhBBGQRYeIcfSWyRyaY0Vl
X-Gm-Gg: AR+sD12eviBzPINAEHBENhw+fZavqYqFbRLYb5gUratQ6ezUM3aNifMb+zrSrPw4nJe
	RJ/m0FnFUQaqm8HOi8rVNlgLB+0erNvA269dTBcdB8YxffCTsTDOHYdyG1N6VehAqCC2TdeyPvy
	IfQxuxsI70R4hHJowRVF09WY24CG4B2cctqw3PXhPDr/Dvjvr5pQZIFSAgOGQf0Ni/PmhuIXdHK
	M/9kgayDxCtvFSrSxsfMv7h9Qm41/uhm5LWNaF+Q9xx2nwK1xAC3yGXEQFnBgisorEjSX+HUyCT
	WZjcL0uhMxVKAJ4oWGQT5qCyNk17sEDLkIxS2Q4fRoC/d6Sj3OFyssyaajWv36uQ3p57TPGsY30
	BLiQgczfPkA4RFwuL3k7IJ63SrskOARz1Xa7GHgrTz1n8yZyMyiUxVJZuzL2BR6LvtOkFTap8kz
	p4pNu0uXt6FciEISo95ky3ykz3UpvJMSep65e/2+dAzciohbnACMQ0I4fyLJqmVJBcLyyCCAvqj
	aIti2sDWqGvvvPy/sttoiGLq+q71bmZwtU=
X-Received: by 2002:a05:6000:2c0d:b0:47f:6f9e:1e82 with SMTP id ffacd0b85a97d-47fec4f11cbmr2929561f8f.9.1785872912132;
        Tue, 04 Aug 2026 12:48:32 -0700 (PDT)
Received: from eldamar.lan (c-82-192-247-196.customer.ggaweb.ch. [82.192.247.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47febfe5c0asm2485520f8f.13.2026.08.04.12.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 12:48:30 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 96F09BE2EED; Tue, 04 Aug 2026 21:48:29 +0200 (CEST)
Date: Tue, 4 Aug 2026 21:48:29 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable <stable@vger.kernel.org>, Cen Zhang <blbllhy@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>, NeilBrown <neil@brown.name>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Please backport commit 8173f7e2ce67 ("rhashtable: clear stale
 iter->p on table restart") as well to 6.12.y and below
Message-ID: <anJCDeWQsBFO_GYV@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greg, hi Sasha,

8173f7e2ce67 ("rhashtable: clear stale iter->p on table restart"), the
fix for the recently assigned CVE-2026-64563, got backorted to 7.1.6
and 6.18.42, but would need to go down 5.10.y branches as well.

Can you please backport this commit as well for the remaining relevant
stable series?

Thanks already!

Regards,
Salvatore
