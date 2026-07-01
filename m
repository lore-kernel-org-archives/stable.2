Received: from mail-ej2-f1.google.com (mail-ej2-f1.google.com [74.125.228.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EDD48125E
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 12:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908738; cv=pass; b=A8+1jroViXSG0X6FPcJxPF84SG1QWIMjMx5jtEq35HzwJwW7r4aThoQnmnlkjtsGCbmC+16qWuxnqBxitkj3+/zosambd9bmrXXokMdfIBgXJ6KNi3QJUd6oGP1eoDtOPllGE+eziieTG0nFzXP6ow580Ra6ifKacvn9baJ3eBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908738; c=relaxed/simple;
	bh=gKEugolkMnTPV+ZSXAHUz/DmmfW/0pCogkat6PL2lfE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=FMTISkxX1LQ2Ws6GdOldz6E6j5Fv5ymkvbycYyf8rdWx+//DO6cMmiC0i5N++5dQq2XJ2D8xLyuToh80C4T8OQgmB5L3VYwuw3tfYGAiIszhSasm9pWtQY/tSA2CoqzbZer1ZK0nsj5HOjrEbploDow71/IJXpCw5pugcqJVld4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgFN03yF; arc=pass smtp.client-ip=74.125.228.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgFN03yF"
Received: by mail-ej2-f1.google.com with SMTP id a640c23a62f3a-c128e8a16e0so21508066b.1
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 05:25:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782908735; cv=none;
        d=google.com; s=arc-20260327;
        b=pX/GXT7NCwEVRn4cio8R16NdnKQVT5eAbd2yMm4d69yxoFrHcDYgiS1wGBTFe6yqJb
         H1OXJ0FJ7OVoq6EUWO6e4CPdGDG1G6nGKGrRTf1d/BzWdvh4Op9ElMN8FJ9exOgXEktN
         vTfI8bTcco9PZkMvb/e6shKcuK250ZreLIPL9F8v1Bt6tU/JiOMvn9PMvva0PnjAn4Lr
         k/bgK23XlSyCix1nk1RJ/8uaLZp0E8sicFMy+MnoJfxnuRmFvodqILhtyNin/qgSJiVE
         OPf+j52Y0Wf1eBwmHzc7Ve5wbIfQnfcuCC0qYz83SpzhzrLOPjhMe7WAmnl43V05jIzF
         Qg8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=gKEugolkMnTPV+ZSXAHUz/DmmfW/0pCogkat6PL2lfE=;
        fh=Ay0fIimQmWlyJmDyAAsLaFCsFv5MDSVjAUZ0oAHksSw=;
        b=fv6q1t84gC0CtdqiMH7BedRo1BHVpI8w55DFv4S4gxmF0R8UaGTmR1p3ZYSDPj7wEg
         n+fXBx0F4jL1Rj+Rb797vRaaTE9l6BXM/BGA1xaE9JK/LX96NsTXvb2BWqAOQT0G2cM2
         JzA7gFg0otv4VAH8EfnlvqKgkngJcVqduXwWCazbF9nDF3AX3QWysdDboaIbLUC4tO0L
         tkGU4j8p6E59MfJ2NDpf6rX+T/IpIcwZ43OqXMgG5SSBwvuHtUUuMtAaNPfW/ObCxgKm
         YhpZcb5dLu9TFfn7GggHAn89JIncyNK33JvJrADAcEYbshBYMXWwb5XRvlPewipOQLfo
         JmTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782908735; x=1783513535; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gKEugolkMnTPV+ZSXAHUz/DmmfW/0pCogkat6PL2lfE=;
        b=fgFN03yFiJ3IPSwnD3aDdtghvCZ+5Gssd6XOQnLsqjyQa9xPRepj+zjbMOnpsPEZQm
         DMeZa2Vyagdedhq5NqS5tCivpnK5I7hsVCuNVimenaspErt6+uYmyetHrMEinctjtnaw
         SrcSRBTxVyoZLIrFAKwcGlukNCv3OCm9LyGYH+qZiJSKC7xp7adjo8pfBNcNoHRt5e5p
         jjk08t7YOSv/+yojBgc/1dz0b5xLA15Aq5/GwCyNHAQdtMfYUc/v3G7Ooxbg1y4nGUkT
         1BatqxWzUgxzaiAZMSjG0kfH0RyYfLt25P+puUAehGG40DEYIzDI2x2RPFCERMLkXxuS
         JomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782908735; x=1783513535;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gKEugolkMnTPV+ZSXAHUz/DmmfW/0pCogkat6PL2lfE=;
        b=nKPFoHIi76uCIvfQpFbsdCDuYAKC9GdGzZLDmWB8tVRorIxUQ976mTxJkJIf6i14xk
         xqf9z3BS+7pw0a2WRYhq+Xcff6MX/ZwIAaZYJI7oYeLGwwJCldt4aOeFm4+V0E3Xsgpt
         58NqiZTkJ/gZEMNXB+sgFAq7mLkTZP+itdjhjT4HEyWWV92/QCrG91M2mwCVmpwHuNGE
         cHHcHCjfNHG+rTwCIjumfUepPnoGnuuc7VTguRY8lzbdEY8fHszAeZ9SQXryGchtYchi
         ctQ3/Es3ClP2p3Zv7xZmnEWzaNn+MR1ZNTR2mN6odtffH8Nog1q2Gvpt/BfxcA+J5qBg
         W6UQ==
X-Gm-Message-State: AOJu0YyVVqnb55CdmpyjkXh6AQCm3boYQhznAp5V+HM3kUG/qzXznc0F
	j+Goa/n2418JJGVktIQCZ5dneE7gwC5Kr7EgB29uyiTopKklkY9awq3j6H/HEcNMDfEoFAWsTwM
	bIlvCWPey3o8XSdfYHVQ/wnZv3GvcFsbi2fx1AqYheQ==
X-Gm-Gg: AfdE7ckgt6SQJJvwJWyaaWEdSUt8XOTFh29muTmjNbHjVXLSnzN2rcXibrTvsTU6R0D
	rBRptfUO/RCNqjdYQcoQAlBLuIlQXhpGnlAvCoNSN3oa2C9nP7rUxiZBABbtgIFnqtizynqXNPl
	qw4ZVIwpFxncSZv2JcJwznQ3KmCutNS4IkLXGiIFO40QqUXREmpUksrXVblvQYEDPs8E/cCnyhJ
	Ere1/Xt3DQiu104DCUU7zMMygPKpukJCHpTMlFIjZ+ZTQMJQ8rHVEZYaXb3BdocbHI3E707AGy1
	IuW2TL4i
X-Received: by 2002:a17:907:3d02:b0:c12:764e:326 with SMTP id
 a640c23a62f3a-c12a9da169amr65688866b.27.1782908735156; Wed, 01 Jul 2026
 05:25:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: sdj asj <sdjasjbuaa@gmail.com>
Date: Wed, 1 Jul 2026 20:27:36 +0800
X-Gm-Features: AVVi8Cdqf7juqn_CbSlS62fGyCkuNpOQ4kTHWhZbn8nJt1Q8Y0TWcyUL1baHDaU
Message-ID: <CAFTRC0=hdHvug9=JyiZ=XYowdpqp9TAgXbq0YpDOEnzmQUWxzQ@mail.gmail.com>
Subject: [stable] Please backport ntfs3: reject direct userspace writes to
 reserved $LX* xattrs
To: stable@vger.kernel.org
Cc: ntfs3@lists.linux.dev, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"

Hello stable team,

Please consider picking up the following upstream commit for supported
stable trees where it applies:

5b08dccecf825cbf905f348bc6ccb497507e28e2
ntfs3: reject direct userspace writes to reserved $LX* xattrs

Reason for stable:

This fixes a user-visible security issue in ntfs3. Before this change,
the empty-prefix xattr handler allowed an unprivileged file owner on a
writable ntfs3 mount to set the reserved $LXUID, $LXGID and $LXMOD
extended attributes directly. These attributes are later trusted by
ntfs_get_wsl_perm() during inode reload and used to populate i_uid,
i_gid and i_mode.

As a result, an unprivileged user can create a file that becomes
root-owned and SUID after inode reload. The issue is reproducible
using normal syscalls only and does not require a malformed filesystem
image.

The upstream fix prevents non-privileged users from directly writing
these reserved $LX* attributes, while keeping internal ntfs3 metadata
updates working.

The original issue no longer reproduces with the upstream fix applied.

Please apply this to supported stable branches that contain the
vulnerable ntfs3 code.

Thanks,
Zhen
