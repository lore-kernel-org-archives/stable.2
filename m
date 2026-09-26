Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B4C411F90
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 15:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790436423; cv=none; b=tyyRAw3U8DXedsjez3DS5ybfjt6//xR3zmhqUwK2DyEOQYS8j6isIVk+zi2itZzMkRpIGU8NuysauLg+9b1eACcHCL2/0BrST6phyu35Ze8knLCt0Cgx1LNRv+DHUKpSMR7ppRCxOsyQmzTMYLmeuCo26uhGEc+tzh3MAGA7Gsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790436423; c=relaxed/simple;
	bh=SzmAPhJSqzo5ihS4UY8Iect4WUU/nMW98tnv+6ln0n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijQwwWsJXZDSqTaD/eytC+z5wQQNtICuZ0UMhPQhmC8mi67Y/7R6MzTlPiP9i+GqkwdM6UaR9bcZQEzEvGZ2AMJkMpKyynJLFnGnUAaMUKBo6kNqh3gA7k//+eoA+F1fsRv+mV+dKmocBJiVUuqgcJhdRiRoi8oZsR+7FLwjsFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYGixN6T; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYGixN6T"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6b885ef8so9917855e9.1
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 08:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790436420; x=1791041220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r93vo6YJEV/n1FD4tzzKSMKvC9BRqIXeipynuzwoWIM=;
        b=BYGixN6TTN3UMH549hokrHRQpoSYjXVP3AGYWJdu+pQHDNv954DFVfkOPC4Z0EhmUK
         5eBPS13/e+runp9s0V8m/5vdYmBiSVhpZi3E2cSnZAHealF3uLKvBu17qK4nLT0EMPLX
         EWQ7wCeq+tGNETu6vQIwqqVVr30EodAKF3EUnX/S2kW7k8sa5+gC2CcDsX5NLi6XKOFU
         Cw4w0w97qqdqX02slJvIcqtufKW7FXh7SF5acuns/otxoiVXKAW0S82UO+3aL6gHQKil
         zOM8xBSYbMOti5fF7sJydss0XH0ghLJvPAOpK1n1vQmRuNT856eavEQ8mGwVGLKA7d8q
         nn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790436420; x=1791041220;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r93vo6YJEV/n1FD4tzzKSMKvC9BRqIXeipynuzwoWIM=;
        b=mBFnmZoQfmnAn8BGFbpzF9HFMo4Y+oIoZedek1jBC65riY4FD8Lt3A+TrQyVXJgfsV
         qH854nQPz/Ng816BrkB+FMwf7Ydh8KA/RHRjcIuY+hg1w2FACtqC71q7sEcQGWc7PTAR
         do7i5znTX4Em5YQga/QCEPovC3/y1YGHZNQazfpd/NfuyLi9xS+yzZViBqGPnPOqTqfP
         rIMZ0vfwuwVOEa6UC5aprPEKFvxaVyESpCJf5aPjhAD7SDX6i860qZcR6mUemeRD/coN
         fQahK24PY3y8YI8cWrrga0uxjTScf+SeniYr7f0y/Vuzf7Bi9DXt67AGXQLb51/s8edR
         3YbA==
X-Forwarded-Encrypted: i=1; AKwUvBwylNgw1LwI43a+JxwU7saiFX0VgSTyYnWdOGqXOARX3P4j9Josn8GH7SbofKXcIKz0CvbcCbg=@vger.kernel.org
X-Gm-Message-State: AFuF++mSCtiL1QDaMqWnKwchX1AxxL/PxaRbyiXfy2L+8Sopim1O3q2e
	vhy2MS/1jFQZNsXO7eAragtq3fjdOI1lXTJpkXQQuky/0CuSx5nIWDis
X-Gm-Gg: AYBFou11I1M5kf8EjNE4sKGJpICQgTJn3ryzVOGeiyNmfDTsa57PjCOvejZz07PYX95
	ojI3fYlXtYYCwx71j8GHg2a/oJTfQY6uqudSlDCULltDntRyl0z4lT7e/wBE8p7clabeWhh/iP+
	pZHbb2GGL3pyX/g/SwferdX67oXQAntypImxzo9ZVCUpH4m2cuFbmX9hmfbt0H9/j++aw7VCVcw
	SaalYurz7Yc/Usv7NmK2h8lYmqAa/j+H1gjOPh7gfI4MaNGAzFZOBMgtDf90ZYskc2Zf9+7zc1Z
	EoySGc5bC2zU4Vd5Rbgjt0B3zQIIMsQZ8bMQHVGDqFlbmUPzDgyKEUKPhq8lMfdU967/Dn9EETZ
	6sXECP2W6ktliRdmSS5ACol7qG5k7FLRkIR3mZS78diRtlau9ro/jRsgk2b0SFECtuUTI8d3P9a
	TP6UnpCGfx55dtA/VRE83jEoN3zaGjshLuXqbk105nYsTfOD16EPJVYZSgXKQtRGnhp1YbfxNq3
	iKIDfLr+lm0gEK720RZYwx+J8A+Xy5328wYGoI4OgBN75rb1qCPICmNR9U4NHZW0nDdvmEnzL62
	NesuZxe4Z69OxOPXi47dE4/ZkKSAr4XpPBSomCzuc+qGga/EcQUvATL9Ex6LF9+8i+cnO2f5I5g
	=
X-Received: by 2002:a05:600c:8b31:b0:49f:fd66:5fec with SMTP id 5b1f17b1804b1-49ffd66616bmr28453225e9.0.1790436419906;
        Sat, 26 Sep 2026 08:26:59 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-b162-c701-4960-a998-3de8-2fce.310.pool.telefonica.de. [2a02:3100:b162:c701:4960:a998:3de8:2fce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fef5fe71csm94423665e9.2.2026.09.26.08.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 08:26:59 -0700 (PDT)
Date: Sat, 26 Sep 2026 17:26:58 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, 
	Dmitry Baryshkov <lumag@kernel.org>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Pierre Gondois <pierre.gondois@arm.com>, Radu Rendec <rrendec@redhat.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-arm-kernel@lists.infradead.org, 
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/4] ARM: allocate the cacheinfo early to fix the
 PREEMPT_RT boot warning
Message-ID: <arfjs5kQjQRb_Ep2@gmail.com>
References: <20260912195552.76673-1-kmehltretter@gmail.com>
 <CAD++jL=7OSrPMax9GRj3D7ehjmmG2uMyws53F8U0x7YGx+RNOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD++jL=7OSrPMax9GRj3D7ehjmmG2uMyws53F8U0x7YGx+RNOQ@mail.gmail.com>

On Mon, Sep 21, 2026 at 12:11:47AM +0100, Linus Walleij wrote:
> > The series applies unchanged to 7.2.6-rc1 and v6.18.
> 
> OK please rebase on v7.3-rc1 because that's what we're working
> on now.
> 
> After posting that I think you can put this into Russell's
> patch tracker.
> https://www.arm.linux.org.uk/developer/patches/

Hi Linus,

Thanks for the guidance. I rebased the series on v7.3-rc1 and
posted that as v2 [1].

And now all four patches are in Russell's tracker:

https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9520/1
https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9521/1
https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9522/1
https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9523/1

[1] https://lore.kernel.org/r/20260921-arm-cacheinfo-v2-5892c4531ad9-0@gmail.com/

Karl
