Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6184347536
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 17:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781112559; cv=pass; b=s7wL5SjqT8dRU6erDwKoXmLL4vTZnU9c1FH5Sxv/mEDVTm2H57gjYtIaxu/yxwwoL9cYWyhPhwJum2f4ff4L6/Y+NAR40xDfAiXCKLPVm4Lk2XeXn9B6/EcsM7rq1k4BtaCG7qS5hPr9IoEBujvA+RCWibzZFOD0SBcec2pvFB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781112559; c=relaxed/simple;
	bh=dZtPxZ7QvCP8QQ0yBF7ZU2Un31AenUtTLmqw2AbkwR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SeVjpQFiyU8CoGscCi8rb5wx94/ofQUvLOoJ0p4j4L9vPRXp2XW/Y0DR7JaU7UQXIs7xcGF67oFaQEmRdJfh+c3vhDi4uHT6KCX4B2swDnxa7XZNWSE6NuATX8sxgSy0bjL7OTteuI5BWWs0nOk/SLxO5P9GiPCL7PO7ZpmxfoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lge5Djye; arc=pass smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lge5Djye"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-915767ea2d0so536284585a.1
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 10:29:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781112558; cv=none;
        d=google.com; s=arc-20240605;
        b=CsOjTcF5JL6G2qD/9Czs58M0mf16nnG2HEvbx9GKmQP+ihaKXCBrisQyv/VsTpVeJL
         LM2zTUEfoYoweJBsHIWZWFjZ/p/CQenhFk50u2nXa/NM8SrP1TH6WURGIhAJ1V0vKXBW
         bMytQ+SK+rIKr3uCO9VA12TxQchgEs0nXxsXuqtUWq+1c3oVGwAs6y/rroLj3Ry06nF7
         GpNiRZd8qSU1R0FeRNz3Ou7AMGgTsDjYaIfE5l2Li4bqifZg70bJTakT1k+CHQi2C0G0
         LMuNTdYDFsyuNlO82b6UdiXtpTGwYDCwjwawMnvHx+CVw+QjcJzZKlHItbA2xxHDyt10
         c6iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YvcRBNwGrBXez69ZPOl81reRTKhIzImY1y43ld3hni8=;
        fh=e8UD/e8s0edFmXOu0sPdcHfvz0gdxQzVcbC7ezgooP4=;
        b=e0IJhWXz+zCZp4nmrQx2S87I8t2E1bbBl3LZ6AVZf+y7vY3RjpbKqKir0HXbzJK1Sb
         EmvPHIwq0025zUE9bjCUdlO8yBCbsud/kXvOXPlu1CAs8h8SsJpYsewwSijEO2REqAFy
         w2SXGnWt1+ongK9Ycsri55f+2tO6x1AqZ/6x3LHnlAGNmn3BsjFyU1qJdKrbgUOZqYjX
         cWXOJrVH9/e7taB4J9zVSOMISvTbEowRKRScVTa5CmyoFc4YGFCd0nl1E+ZGhiHRvzoP
         QsSdCZ0eksDYxaahlMOPA6ZJ7weukn0G3YJiExbwbzvcB3bP5csV7JvBGSwP+q7erGk5
         Fh8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781112558; x=1781717358; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YvcRBNwGrBXez69ZPOl81reRTKhIzImY1y43ld3hni8=;
        b=lge5Djye+DBe/ykOA/LaRSmTMgG9b0L6j1M+r5mkT9PwZn1LU42MJi7K6jAzq5tHjG
         o5WnT0IQAD1R3P3BctgGHyo5QchZl6YGJGkTforj3wqV/oC7hZjSXaL2SdkvaBaXU2iG
         iKTNuc9JF/ERouWZsn+fU6kiDSig7L/+fSIxtR0PD4YF6ZmKU9M4ivfJ2tXXvzT9mGEH
         hb7nm3t8qJxWL+YkEM8d6Ja6TPJu4Wt5oq1ZlFtOOwVfZNi+/U7KYEA1uk2QfsvlTjZ2
         NfQhezC9yAEitkBl5+O97wd+BcUJZYwVpxy+6ntOuzCXH1vCxL/hsup7R4k4y+DpoROq
         zGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781112558; x=1781717358;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvcRBNwGrBXez69ZPOl81reRTKhIzImY1y43ld3hni8=;
        b=oyZDf/tyPOXK7U+ru7Pq+GPgrz23DoKGxjbYOPoqMEBu9wt01LaMtMLL7vZN9OS0Sm
         usxbNqP2jGfilcXuBVEd5fGfwaKe/ksL3Yts3hYVRAQOd1bB0ygqQR2ULvkvrcvzE4M6
         tagiJIb6UfPZ0qx/lgsqSrc1exx0/btBSILsoHAAMbhPjqreZzTC3iPQJVPyIrE6A41d
         7IhYh+nudVYFTrQgtOIRYplXgZt0yIC5Yz2Tj/YCj2tmbV4y1CnksSrGiZpZgyNJzQDN
         0XE6+YwPdGisVKOTnUYfYU+e4oUKyqhWXq/2DK49UD9cDKv6cqlekBC2dNKdwsKJt/Xv
         qhYQ==
X-Forwarded-Encrypted: i=1; AFNElJ/SqGs1FVrW++AITS/lqz/miYtAx8ey+xAL9PCYNhtWhiDX+1ZzAHnclrTaVOY7fzJkNRBDXrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YykLPPm3FnECHqc9ogrhX34p3hpWEJsO8VYCdxc4Me21RiqFPuf
	wAONx/5tdIWeZwnd/MN1+kPho6A6FJWmTN1A6ABWUrR8V2nYf7TqirNnKh2EHldmO9T+z1bbcu2
	63lWUMSYnpylylfaWWJUHnqkzfvrMbjg=
X-Gm-Gg: Acq92OFuZx0EW1jugnRvSHxrusfFkChu2AE8kCn7xZmEmNVtETSYtJGlFeu93xkS2XJ
	meyxPBtuHD+vBReGYFXzmY5WjNZ0E3YY4TBUr/r+NCbSZiKjgCQM2xkGCXN1kBaqyqKQXyoCNlz
	f49WxWuXRomuU3xDwFDjwpKpwswqLrvdaWaYWFjEWtTcZrkxHgQnaOZ4p1jj+HF1NsmesSVQIoo
	cL48x7qaGnIFhzOUEgWe++c8aTy58TM5e3XD2N/A8rnn/+MzCjOQ/nqGPSIS/3anmjE0xTpd0L1
	4Vo3TnyhjR3pA84jUOyKRx5/VmJYPtdjESZWWeQRK8vJQPUA/KU=
X-Received: by 2002:a05:620a:1d01:b0:915:9e84:85ee with SMTP id
 af79cd13be357-915a9ca7655mr3990050385a.15.1781112557739; Wed, 10 Jun 2026
 10:29:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610114120.3748526-1-michael.bommarito@gmail.com>
In-Reply-To: <20260610114120.3748526-1-michael.bommarito@gmail.com>
From: Justin Tee <justintee8345@gmail.com>
Date: Wed, 10 Jun 2026 10:27:27 -0700
X-Gm-Features: AVVi8Cf6zx6NBJB4VzYXKUC0RH2Yw7GxC4AbEF3c7mLb_BtSx5NBpesjROBhCBM
Message-ID: <CABPRKS_HbtV5vWx5nHT9rwJV4TGmOPj670yUuLK-Hd-r6TBF1g@mail.gmail.com>
Subject: Re: [PATCH] scsi: lpfc: bound RPL ACC payload size to the response structure
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Justin Tee <justin.tee@broadcom.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, Paul Ely <paul.ely@broadcom.com>, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Michael,

Thanks for bringing this to attention.  The RPL ELS command has been
obsoleted from Fibre Channel specifications since FC-LS-2, and there
are current plans to remove RPL ELS handling routines from the lpfc
driver entirely.  Therefore, the issue this patch is trying to address
will no longer exist by the next lpfc version update.

Regards,
Justin
