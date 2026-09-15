Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com [74.125.227.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B2D435515
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 19:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789502225; cv=none; b=OM5fTqONjA1Q51tTDkVfClNIBsoC5krzffsF7DpsM9zlDgZPUf4qxeG/p1x/MxlccQTD/wlxv8cPriNwe4gl1BLx21+0pZ9nkYxxaejWvTv6NHvz+vjNI6Wqh9j5mKTp02q5SUuFqRXGXqmEYSiX3TIlMthR2CvpMCzmrkEYCEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789502225; c=relaxed/simple;
	bh=5+nwfIuz8ZbjkA7MsPGWMFLzJnQRW6j0etOXe9L5Lho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CRnqgJxYcZMo9MziHjto1tyhbA3VvOY8cQhxMu3WYvasGwCN7Knu+NARijpqUolnb0oO2JBlgOUeGnvcZkKixvZY092SDehDxoSUlbTnBdViqbXrsFzpXOmzxl3lyTqdjZY/owfanwkmAuTDHC4PVgBRilSE65lFB/zQ2i27UWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YV3/vzTH; arc=none smtp.client-ip=74.125.227.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YV3/vzTH"
Received: by mail-vs2-f42.google.com with SMTP id 71dfb90a1353d-5c8319dd4a5so78674e0c.1
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 12:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789502222; x=1790107022; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5+nwfIuz8ZbjkA7MsPGWMFLzJnQRW6j0etOXe9L5Lho=;
        b=YV3/vzTHWkDzLHi7R5YtsXD4SrxE+7/SJ1yi2Dof0gOwjnCi6fdN9Am4mODDBoDU1+
         K0gQS070F7xeJutbZE6FnVR4OoFdkQaUmlBYPiA41FAST3q2AMX8FtvXtygPBa0xxVvj
         +a1JYtoBunMPnFyoyZ43Z7GKklxXU7TQwkjqCFWAIFQujlf6/JVPwIqE+u754Kc+0urS
         yGy2mnf5SFtIqZowusUiDMTabftiqLB4HnhQ9rhvxso2FwPABkwvYDw0dso0IEM4zR1Z
         BTnat+RjpXk0uVPw5b54eU6H4sP0GA+6uDKzFKvT548vyrwKsq5g05mbtahL+1XT1Ebe
         kOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789502222; x=1790107022;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5+nwfIuz8ZbjkA7MsPGWMFLzJnQRW6j0etOXe9L5Lho=;
        b=1JuUdZah0XLe5wzaJ/cVVFhxgq/NmiWNqBdwbdIbS9lVvCWe4uaHlSIkFNU0b86beC
         kH4moFJZtilf0IR8Up1Fht8PzOXXhOitCbPFn2+pzF0lOKjcLnPAjD8ibAv0rYhynw45
         DiYV1/ZwuTQaChGFwlLVVuMFjCoX98WAGViCxc7QWKqhG36lHmP7U6F19zA3tHGssgzx
         y2m+2seWEuNurzrhfiJ5Vi4uFfF84xXZI0Z22h7ID7lesylf0GJucDU9X754DmTnCVbe
         P+tJu8/OTDIfO3AERkRGZAMG/M3obhDSwGjj2C0ZiqyCT6sikYvbFTymPEhRbAoNnHpm
         wvtw==
X-Forwarded-Encrypted: i=1; AKwUvBynYnow4MORJc6xw3Ay15zLkYgTbMJjDOM3lPGuiGrsTZ4IafNqpgmqA1LvqMUAkuKoDT4C4vQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kt3y+heOLd9vXK/nDgdJ8PD3gZ4sQI33XZAF/jKPTLdqX4lz/9
	nBKtiWTnFb5iz98YqkkJU92m9b/zyHdzf25P5ZwSTVHH9o6DwNcGcXT1
X-Gm-Gg: AYBFou27UkC0FOKpTX44V0yHjFplY8L/S/CY0VvzyKEcqMzjeDkk+o+FMGS8mAs8lHW
	eep1jafcImASlM41VALc+rKPc/4b60DSVaAmzhh6d0lNDZNPJgW4lqbUkz9tp2+VkHwT8uaCged
	jE7eYUZMUJ3wsr3aP3j/wSg71I6A5TOo8O/q9idifuewt6M8OPGFt5KLHc4+UfvVzjE4jyPi2IO
	FIKrZBHcDuE2LGu2qbAcbZEz/nQmDDkfkf8H/qPuX4burfuxxztwIMiRd9Tgh9AOYrj5k5AdHsr
	iNgErVEheHJJE1t7fkuC3pkOnNRDm9LfxybllyUuecia7a3oF21RDca9WGn7vJvHjo60tNGCFjy
	8bbvwHOH25VJ11wZNjmhOKBoea+5G347pxF3A3w+jdw/FN0EA3cTXvX457RjhRx3FP/PGfr5brM
	Ic6FsOrz/Y9Wy2GuD8hbaYOqY7K8W1TenfpIJu2pVgMRa1mZ5pZW9hkuSqws3INPmI
X-Received: by 2002:a05:6122:e266:b0:5c8:4409:602a with SMTP id 71dfb90a1353d-5c981e978a6mr14043087e0c.8.1789502222518;
        Tue, 15 Sep 2026 12:57:02 -0700 (PDT)
Received: from beelink.. ([187.13.206.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c998a6b665sm566060e0c.8.2026.09.15.12.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 12:57:02 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: Re: [PATCH] nilfs2: validate file block counts during recovery
Date: Tue, 15 Sep 2026 16:56:51 -0300
Message-ID: <20260915195651.3335615-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915111351.2726334-1-qwe.aldo@gmail.com>
References: <20260915111351.2726334-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Slava,

Right, -EIO is more appropriate for corrupt on-disk metadata. Will
fix in v2.

Aldo
