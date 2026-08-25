Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584243932C8
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 10:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654341; cv=none; b=S9ZK8vkQ3n1BihBRjRj9EAOKNiBwZvV4fbFI9sQuKC/kpanzOVb6HP4ihjCGS/qOO5jKnzldyjgK+nnwwPZ0Se+i85PoZyF6zKayrXKwZXCJOCJpeMg5Zz0Xi4Yra+M28FVgBHy5cJRYqH4yQ5wgQiubp8l++3gbH6nUWKsaC0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654341; c=relaxed/simple;
	bh=ISVfKl+9f4eR/32rkiBd6wjP58kml5FEuffdft25DGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GEEZlehRk9MnXyDVVpoLvnfGs8F8ntXYB7ELS45imPN3fd2xDM2eEu0GgRdI6zaFi2TKyBxRw8gRXdXwNo81weunrNPc06La7BefANJliMo2pup7YwAhd2SjzHVZ5cOobS+F/bvDtYT6V52WEPj5KI5x3KVpvX/aicCkD5xn1ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJWfqkOp; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJWfqkOp"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d0407aedd6so48557765ad.0
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 03:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787654340; x=1788259140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zOxGyS7OvO/OsJZNuAy0e1GStWon9PN34Vh5qY3d7Ec=;
        b=UJWfqkOpheKnj0bajVPeMPBrIEknVU9CSwwXO5TuOwyVKtBM0qqNl3fJMsr+2FRLce
         6xXQmFBodXtgj5GUmTyjJZ7Y8bz6LjfKtWPjUlCrkeYi1wrN7XVsyr6SL5MKiOTB0z0H
         bHk98tHa+1w0cKM5Ocof6PUx97ne0kwMDrtwt0HShCCMT/Vabdr8PaImU4+4FnGKa0vw
         kQ24hqQSTPyMdS3BZCjCXeV4S4l0VYCqru92QxzhiTfJwtxBVXHZteB8cGt+d05Q/Nsk
         7JlWvCmRphP0ZJQ7TOBfHipnsIi2k9kHD7NxaU3Hx1pFrChmTJKW/iKKJIlXLXM1nkGc
         wKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787654340; x=1788259140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zOxGyS7OvO/OsJZNuAy0e1GStWon9PN34Vh5qY3d7Ec=;
        b=Tt21kUZyDobxiRggOqW56i3gi4Dj3omQsCYSgnEhGaDNAuflb0WyIpbmmjRv9jPxGv
         quXPhn5yHN5TSX1sPJNhQHOQB+lIecY5YnaVHzzB2l+aRSE32xrJl8nuU97bZi38AnJH
         wD/nyzkC5lksBAY39dg7VOyYpRcJgJv7sa3BWAy7hSkZIMi+QgxtM1DCpie0fAmoQeXh
         ZSD91ateKz/P8Wg86cza3ufGDOzEF1mxjcLa+F1pXjtHYkuNRZjviqkV1xCfGrEN6znN
         MGZK5pGiAbR/QKu0i61yQdzSm69IUTeUlxkB58z3BSNj2AB6+/J1Mtv4mO2PCccnj/HJ
         ILZg==
X-Forwarded-Encrypted: i=1; AHgh+Rr2WCfrFKvMAlhnYRGgtErL0vr1zRsvt/nzTvWWZmTT4jyaj8O0J0o5j4IkovuNivYlaAUUBYA=@vger.kernel.org
X-Gm-Message-State: AFuF++l5EQjM1KwW0e2cTdn/ucNS8VcCJ6CzdF03E54grarJyawKiIjC
	oc2GXWhwdRuj90YcmB918Ljyfwy4XdFjgmdKM+EKZJ9/ydiyK+tY0rAg
X-Gm-Gg: AR+sD11wDmC1DCqUTg9LMMvx++57hcrnUZSiy7EICcO7n/biVtxpInABhQEU1/mCjm4
	VJLVuwFKYM+PyDwjlsknf7dpmAkDSdExPgd3PaXLFLxTf22+9w2myOLczeuwDMDJR3xqhnVtdRP
	C3wZC8dq1AXtpqZ4mzIP1yMpOrW4GGLEt31LnP6xkK6nc6zgAPAQdugpZASCOgStQiY4baIulgy
	1Y8pKeXgME0B+X26bAnhBCMZ5ExGoM1vHmF45KomrCCA3zu9WRjDZ78/bWZa2udap0CG+uj1GjF
	QsSClY4yiaE9Ec73wBQmEUEhzdkC3xXIxI9MY3M7L65nu0PzqvSVb8EETZb43RJ7vvGPO/U9tfx
	5J5CHPzmjtXqKqwDl+DQKNwmlX95A2Lwx+7vj1PA7gG10SLKYztz0nJgVpcFuP7mbeQa02cCgZo
	+nNBmJ+bv7iIN+WU/bx+37CKXzwAnb9NOeRxhOKsGPVcGCi/sm+Rm4bQzZLq7UGcwH+loGm/JZ9
	E6tYiNSFa3FDQhNwhkuMQntB7ZwVasy892hqaY8FLgjCD/IWv61M4kTwR3CeIfAE9MpX3ZKGNJm
	Cs8EZqhXUQWgnA0JII2SrOOF
X-Received: by 2002:a17:90b:2243:b0:396:6344:3b62 with SMTP id 98e67ed59e1d1-39663446107mr967320a91.12.1787654339704;
        Tue, 25 Aug 2026 03:38:59 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141860c6e6dsm30917319c88.1.2026.08.25.03.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:38:59 -0700 (PDT)
From: Wei Jie LAW <98lawweijie@gmail.com>
To: 98lawweijie@gmail.com,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: aduggan@synaptics.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] Input: synaptics-rmi4 - remove the F34 sysfs group when probe fails
Date: Tue, 25 Aug 2026 18:38:54 +0800
Message-ID: <20260825103854.14189-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824122751.76415-1-98lawweijie@gmail.com>
References: <20260824122751.76415-1-98lawweijie@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Jie Law <98lawweijie@gmail.com>

Superseded by v2:
https://lore.kernel.org/linux-input/20260825103134.12278-1-98lawweijie@gmail.com/

Please use that one instead.  The only difference is the Assisted-by
tags that Documentation/process/coding-assistants.rst asks for -- AI
tools were used in finding and fixing this bug and I should have
acknowledged that in the original posting.  The diff is unchanged.

Please mark this one superseded.

Thanks, and sorry for the noise,
Wei Jie
