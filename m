Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3303BBFDA
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 14:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273545; cv=none; b=YgV8NaPzOwzFgE+HrsZ6a1MpmGLCyj+H5B1jikqvpurfcZETNI6dhu8+hnRcoFHpMbZ6oSK4aWpv8BLAjM3BDhpx13F66LvA7JpBu4y/xeLLGqDhMdthHu24hDSwaI4jLNzlXu+brD9SaT0gZZ4jNMT4Rv0u24jSOKTHirob6bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273545; c=relaxed/simple;
	bh=r7u/T8ZNDl+uyzR2azorBU8CNtdm7Pa6QjDI1TYLCHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxMoroNlV3JMdwX6eqP9tGBPzLhAZPQvAqCSeHWaiUmHYmsYj947ge5dMpC5x5tBfcHmktnMDoJFSf8M6cMkuortv7m9Ox6fqGo/P4ZWwWgHbtLJuNyC5LjLqt4m7rdFsnf/RdTfvDyLvtJQFPHgU4lmpBvaamznnjZLiOtRXOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlQzTFnZ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlQzTFnZ"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc1cc1b42b5so5192044a12.2
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 07:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788273540; x=1788878340; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WCP5v9cunsDtMZ+MfTVTBSIXh7DdS+GKm7AnmrVBdkY=;
        b=jlQzTFnZya/qB4/QtBk+PM6Is5EjGveLROpLsdjL3an/EeuOWM7DADPFnpcyPrmlyA
         4DE1ZB3+UIdHtJCP2sD1WBeTY6wkwg3i3j+QmPsvMc5kAg8QMskMwW/SCElk5t4j7Pw0
         QrxSFvfWIhVw9RLr1dw2/5gOC53g9wmXU6pQywBrcw+w3tu1EtbIh3LTMqlXripBTQMg
         al5htYBkzUeBPzZA/RHvvwW3HlSPX/Q16yt0rwt1EKg4wYX00JTb9GqCCzx4p1gLSLne
         J3X+2kAHPUMFQRJykhRlJUC35rkrpksUgQa57byGf3LO/VC1GalA4R/tckVjHQanLH6a
         nY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788273540; x=1788878340;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WCP5v9cunsDtMZ+MfTVTBSIXh7DdS+GKm7AnmrVBdkY=;
        b=ZuWoRt83uLVSb0vjIUuTAz5sPGnkhuXwZZ6Wlk8HiIA40RHKQDwQbKIgGjG8wsdJnK
         XztRBHbItpii8oe+rSwZr48T0m9rSfgSMom4oA9R19qBL1ojuOAvMlyhdLmUKXpSJfOc
         tN1uAZojblDnB4ZO/4GI0RhEuB3IYYLMjf1TK9dOVjyZnEYqJGtUpl2lrQ75tyaEOI06
         vYGvBpcRCznOFPhJ55LlqHeGlazyYGTFtnaeDMILpW8yT9dr9WoRwWMOnLx3/sHDKIHQ
         TyGZzsYElPw6JCaDqNUxUvoD5EAVLwssjTz8emwXVTaPlgMuoKUmkInAsB4XCgzSbbMP
         AI1A==
X-Forwarded-Encrypted: i=1; AKwUvBwzaQvsvU87UL05lHAZMGplwP9o+CFnuy5Yfc8PCAFoTg1NYWeNFFEY+2WAjQRK5J2aXGh9/p4=@vger.kernel.org
X-Gm-Message-State: AFuF++la+agTtXAo4e4mRLURXV24y1Xo7xJCKeYEpwuHTimr4ycot5GK
	i8/6Of7Tyavf+sRGHyrJwA5K5bgbYKNTSLS2QiCkDdVqdXQnB20y8uNO
X-Gm-Gg: AYBFou36CLeEbGuR0T6DHhAuwh/07x4dIBo74DUisSw7qFwQZq/f64Art5DO9N4OO4K
	QAwcy9a9SwGd84eopBTiw+TlhUJLj4ftqOpxK8ReQ3imjsnnYhetfFpkFFo0RdCxOavLDLTG0Q+
	yO1wKp29+PWwLiGKzrfDLCP7v9vGgtCDY37jvCqKXlBdCVu2wlGZOpu1dTJ6nHWxvAhIyHm6371
	q9JD/mVOWqxXq3rpFdMCfWOCCOkBvHeFEf7aZRhgzQGwsbvAOdcYaZWGsW+3GMMdwrdO6wrWgLS
	3HxNSyOFgNhpgYQmzPd02VOMAPPM3K19E6SvM+/YFVCgi0InOAPbgPWMqI0nlv4vY7kXOiB3uAF
	Xnc00yzlajQciPIufKvLWV7FFPEgRMyD23PobBsGWQjvsDXd1roAJrSw55NofR3p4yyXe6WEvNr
	BDZH4hMP6AyrLDvY0kiPgbYbviAusQWwi/Zb7iBsN0EXQEPFBM1jELV7l82tD0XvktmKpwztmN4
	YyePFtNvDQHJaOSR0A4RyUmD/Mzy59nys2D8hBc
X-Received: by 2002:a17:903:2f0f:b0:2d8:d4cc:be65 with SMTP id d9443c01a7336-2d94a905007mr122769805ad.18.1788273540146;
        Tue, 01 Sep 2026 07:39:00 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:b762:f84d:c25e:f7ee])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32b28ab0571sm32279537eec.4.2026.09.01.07.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 07:38:59 -0700 (PDT)
Date: Tue, 1 Sep 2026 07:38:56 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: =?utf-8?B?SXbDoW4=?= Ezequiel Rodriguez <ivanrwcm25@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 0/2] Input: fix two kernel stack disclosures via ioctl
Message-ID: <apbjbbhmvd68v9oQ@google.com>
References: <20260901130629.24078-1-ivanrwcm25@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260901130629.24078-1-ivanrwcm25@gmail.com>

On Tue, Sep 01, 2026 at 10:06:26AM -0300, Iván Ezequiel Rodriguez wrote:
> Two places in the input layer copy a user supplied, possibly short
> buffer into an uninitialized on-stack structure and then keep the whole
> structure, including the part that was never written. In both cases the
> stale stack bytes can be read back from userspace.
> 
> Patch 1: EVIOCSABS copies min(_IOC_SIZE(cmd), sizeof(struct
> input_absinfo)) bytes into an uninitialized struct and stores the result
> in dev->absinfo[]. EVIOCGABS returns it. Only the resolution field is
> currently cleared for short sizes.
> 
> Patch 2: the compat path of input_ff_effect_from_user() aliases the
> native struct ff_effect with the smaller struct ff_effect_compat and
> copies only the compat sized prefix, leaving the tail untouched.
> input_ff_upload() stores the full structure, which a uinput based force
> feedback daemon can read back via UI_BEGIN_FF_UPLOAD.
> 
> Both are fixed by zeroing the structure before the copy. The patches are
> independent of each other.
> 
> Compile tested on x86_64 with CONFIG_INPUT_EVDEV, CONFIG_INPUT_UINPUT
> and CONFIG_IA32_EMULATION enabled.

Applied the lot, thank you.

-- 
Dmitry
