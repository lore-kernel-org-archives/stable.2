Received: from mail-dl2-f33.google.com (mail-dl2-f33.google.com [74.125.229.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00F8493621
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 09:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588595; cv=pass; b=qswK7K5btB8zEVMe7OyU5pHh0RTSHgm5oQoScHhirjvwY9W29C/cPaGU9soF5Eadl9ytKFAfWkQofYkgTECHYsWj37eLtCDDFdspiLz8LGIstofvp4OA9Eho6LRl6XPXDtR4ADdVzIpAAWT0HnaaeJ/DD2BFBOZpIrGIGrtAJa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588595; c=relaxed/simple;
	bh=mpI86aIPER6aS4vRP5uob5Y2IurH/cMRVH/mKFJ6e0s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=uAkktJJj6zgJ35M1tqGcZ/EElkA6PE9xUvsE4SITRjRFWsdsp5FghIJAyG/mCcvTq6AAkKwk8EpF8e7nnRqlWnmIotR8AwrOPulxrWqNxBzMa5q8E4UDaKUqVAIefAFT963FnBxjNnCS5sIQSaZbxbQc9SWto0AB7M0kf1eOwd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdAcN6Ea; arc=pass smtp.client-ip=74.125.229.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdAcN6Ea"
Received: by mail-dl2-f33.google.com with SMTP id a92af1059eb24-1438e88300cso2404249c88.0
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 02:43:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790588593; cv=none;
        d=google.com; s=arc-20260327;
        b=IiezSDwPMGWxNa61Z4z1gDN7Y5imnhD7zNHHUI5vyLeKk9Vhkycl6aIs9SK9mUBjo7
         pqC/S1fPADOorBrIhGCgKWTOZ9yMeXXgHoVHiMW70M1poTFVSCMh5TA2Rb9eNbcPXU2R
         mU3Ih934p1HGkh9Bvhb3e29DkEPbYlB8cRrwutHVMnLmqgkxP11c/PQQnlt5V/NhvKCm
         Xpp4AbyHw+0fAXEq1UH+y0UY13OWm1la2oeh/LYUtQk3BBC+yYbXFrutsbSQqqK3JtJ/
         lMLhlFWzxdCveM1kUSpq/R6XpEc4Z9eyBr/axUfYSdnOeftATmZ76yQOnvVbyE726Kkl
         QdMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=mpI86aIPER6aS4vRP5uob5Y2IurH/cMRVH/mKFJ6e0s=;
        fh=U+7JAqfo8bYhet5oa9n6JSap7foMC7UIbmzapl/+7mo=;
        b=IY9myt7CFgmiAn+ZXyHReWQwjvk1k7aDcJrrMkXH3q+wnEwKJ9vI4K553HygLY54oU
         VxVGnGnRQtVXVmIvhZVnhfobU/nknbJjlnzd97kBwz2rrRcCd1oW8mR67C3kyzvLFDO4
         qxugkiyJ4Gg72L7sHiWRSpED1lFI7zLNZqaTJTjsh0f4dCX1xrRHmgboDIVy9WUn69fk
         Has4ePFF0ubq+u0ovsKWGhvQ51dz+JzjwAhuqRLjzrdJsJdk29lSicSFvsoioMjEoaVR
         7f4F7Ieies8Hzl2xU/s9uD3lc2YZEwQKvDtgeraoFmVu5MxoKmW5u0bcGb/Yksv1l52D
         7ztg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790588593; x=1791193393; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mpI86aIPER6aS4vRP5uob5Y2IurH/cMRVH/mKFJ6e0s=;
        b=fdAcN6Eam4buaMrTx/ECHwKzNpnWWjpCyil/UY39tzcMtMOiZiaoiv1z5ziuA0FgcA
         jG4d3SlEjU71xUItbDkT0ftEHJgy5K/9fpFExWvgxzvbAZId4iS9TNjUTZ/H7UneQf/I
         aiC19zP/IVR+PNEPv2g7i8CMo5EzaCdJNjdAtj4chtzE6ywZmk6Cqxlt7yomDANuDFNS
         kAk3Sa7u57qOck2w/FfF3VUzRzlU0SmMv6hV/YhfkW7jyk6r3htKt6uIEH1ITe/24V/H
         a8cV3dGYuthpPZbc/cADVoFb2JMuxyEdvBWQ0LuWu9H7pZcP+I16eZouDcV8p3GRdTRa
         6xtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790588593; x=1791193393;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mpI86aIPER6aS4vRP5uob5Y2IurH/cMRVH/mKFJ6e0s=;
        b=sD4GTNXCTv3Zn0pKP6WNMj7E1w0GmhBEJTP2LcrzAPEszSxuiAfwf+rWDiZ9FmTKbM
         c4lGPLT6RYtAkB/cYZxP5LuRMnlzSSySIX7fQ1ap8FB74uwDflH9Iq5878UaoOT9JnZw
         wcbTL2fMpkVSCzV6wPjXV2J5DgouGY1A/W4lCTUmxeyjVxiMcUMUc9Z2X76KDLKm1UuX
         dpPhKlHe2C3RHUvHO8aGcWugEzpHUtyB6JuQj15ZNtxEFzDGv9n0NFp+Xg3E4eleVmlN
         JPxF9nYp54J4HlvPmqlscUpCOROeVZlegX3+dwTD16661npyrQ+mkhu8NxhYkjk0FhUC
         tL+Q==
X-Gm-Message-State: AFuF++nLJ0FcRadfiZmyQZ1VqFROIQ8qs4e+aIWq/fRRdkZ5H5lYdwhi
	nbQcrFQdBq7UbGLXTSFxdJiKDTxU9BonKGD3PEmgsnUPLl6RW6XzY64f7/0wNB2UD14U6J+SARx
	6ylsnwrr9vR7P7d4gK4AwK7QX54gLKoo4SQ==
X-Gm-Gg: AYBFou1BYlv8SckTchh/aH6JpEqSZFFz7w73y2HhwPN7fe6VztuyfRLqYX3tEspb99f
	dyJIMkNGqhDiAObx9BCekPTLnyKIJ+S6fhKwe3+9JpImBpe/Wy4Tw2idiedQCzSklSZsQmME28H
	si37FPcYTGzVtogrYG/rA9yafDEIKCfzg1stxMAqB7jCIyayPEO5Z7To4+HuLKUNxk6p55vCKUN
	0R/MIYXu2e7cCTDFETlnTPII3sBQcg0ByQprCrzfmKuS9DzW2OcLtIiXh0LvrCUMdg5qJ37rn5r
	PSX5YqK5kqReZ6iM2HBKbAAiUrgPZKZbSGK5kRcZMLS9hvNnvSYK
X-Received: by 2002:a05:701b:21d3:20b0:143:2967:c0b1 with SMTP id
 a92af1059eb24-146cfdcf205mr8956402c88.25.1790588591827; Mon, 28 Sep 2026
 02:43:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "H. Haechoc" <h.haechoc+kernel@gmail.com>
Date: Mon, 28 Sep 2026 11:43:00 +0200
X-Gm-Features: AclHuK-paDNo1_oeMcjcDlsl4kel8Zenvuf3rNe7Gk7QiMd-yfo6tLreNwey0sY
Message-ID: <CAKp=m=Assw9TBMVQbUPSvr1r6fLWFn3=0iMT9NOJ9iE7C+x78w@mail.gmail.com>
Subject: [7.2.y] Please backport 41112a787f91 ("PM: hibernate: Freeze kernel
 threads after image preallocation")
To: stable@vger.kernel.org
Cc: Florian Schmaus <flo@geekplace.eu>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

could you please backport commit 41112a787f91 ("PM: hibernate: Freeze
kernel threads after image preallocation") to the 7.2.y stable series?
This commit fixes a regression introduced by commit 783c81098445 ("PM:
hibernate: call preallocate_image() after freeze
prepare") during the 7.2 development cycle that breaks hibernation on
some machines with 8GB of RAM under low-to-moderate memory pressure.

The fix applies cleanly to the 7.2.y branch and has been tested on
7.2.5 and 7.2.6.

Thanks,

H.
