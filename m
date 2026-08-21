Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A214D3451DA
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787325086; cv=none; b=SrtZR6wq/U8X7a8ST0v2PwxVaK5dWGg1LRP/oy9jkDN/MBAU4WaxcrfK9XzDi/LX7UF1AqmfM5mffAw1Ruvd7dJKOM0iXGoSzyk6WiclA5j97xn3IoOx9yvH25a3gVivr2swhmYe8B4DeCfYHDz86wToGgNzQOVoeJX7b8m12/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787325086; c=relaxed/simple;
	bh=uLmj3KkSrxFi6oZNFdb76IGaznhYQT7Sz8Hem0vXFeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ClWZzRwzIx3aEZBWH1ys6J3wbHHpJBqoTnKOY1ScFJ1Gf1oqA9+hTxyol9UnW060AQkT3hoHMmA2+YDswzDU07OA6i9nOTyZo4cAaeTJaP/dY9fkFiwB+gqaXPEoIToey6qBj3kL2y8T93ab1UUdeDAg+TWj/3aY5Lq8f5kDAq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Om0n+XBv; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Om0n+XBv"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cf50c6f235so13794905ad.0
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 08:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787325085; x=1787929885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r8HVOP/ZZ67PrjnRM0sx3QubuBlJCUlFS75mhhYnPKM=;
        b=Om0n+XBvPkns2XUklLo1aokQzsdRHGLgEiY8IsWZ/kK82I1Mk8RyiBoXSneYYHasRf
         0EoymffsvaK3E1aLEdWXt9JJ4NcdEgFck4M1tVH6+fuGa3qd2qZfdPc3YmSiBNCG/MlF
         ZWmxifBXQiVWoByQDoZuR2wHXTa9dgQanu3ieir4kICS0z50omnsPbM2fbx6AnPvcJC0
         AuvYzE1ypQwNiZHtG2Ck9b9+OwGVbEvEHEFSAQchCKbRgSQs1V4eR7WkTLK9vpxW2zGf
         lr44VLgKCgq0Dvh4wG5TNgpoWridkPdQfG6xV9jIPC4z5tW4kksF/LtVwUGfO1TYznjV
         VKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787325085; x=1787929885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r8HVOP/ZZ67PrjnRM0sx3QubuBlJCUlFS75mhhYnPKM=;
        b=AI+ZFMASpTAdEQl3dL9U1z6kd/g1a21BMqO3C8KVnCzAwGkE2tGJFi0H5v5dfnGzev
         tRjJ7hj8RkXVYCh4d7ktya+Pid87VOLbIbKHzINwn56l2pyb9R33uXDS9imyMybU4poz
         Ms6x+8F7illG18X4qeJ1K5aD4A7CHK5p++HHfhiWkGN7FcIrC9LqcWhzSwc7l4rq7Bgg
         6Em25HNiGShWlKa+9pZ/RfdiiRDS4SCvJRLVUxCI4qHi+KCK8yUzD3oXpLV3z1Mq4iun
         eTmCzTt9G+38+t6fK2Ki5/1poW5aroKqlAKlQQGzFvvuhGGcVBoy//QG8vNx/vghk3/1
         eVQQ==
X-Forwarded-Encrypted: i=1; AHgh+RoUPfcW5Aj9VzL3VpsRFf3UXESaco2F4csgr5EoVTVJh3rfwmirIcF1eFy+sqabC8UNM6sr0p4=@vger.kernel.org
X-Gm-Message-State: AFuF++lD9nCppxX1+t5rYxQIC2mmxw3aFEC38007H8xp5JuuWBqpUAYv
	N8zAN0bM06VhXCfETd/p13SNbmkuIaNta+JcGhO4ytOisMfHabzULu9kUcWyhw==
X-Gm-Gg: AR+sD1046+wdCulFzoMpB0/pwYHe7uj6GY0imEeKL812OOv1vOkKk5Ss9dAw+STMkNK
	WrY1RYZdmC9DCVBNjiHgLn0B20nz7hDJJ7UOvaEB5xS/z+Y3NfUTYYaHmPO4plmpO64QZFzhbdG
	EWKO2KYlpCr+KB9oR+3YyBWjHscpd4aMBi+x8yLBTjfsuoWMdmnZh6QUGDjfCwZpkM/WBZhuHIz
	wdLfPHlzB0e6r1VY5RugH8FAWbI60+iB2Ia4s3iNLqLzVm59vnq1k/18/Bw4XQBVWe5Q610Zvyk
	tq18fnd6sa3JEjpYLXwmNlA/kulYkZ28vgjAWLG9/1nwnPKL4dR7GUz4xW7uUdFiX9zL7clVE8q
	b9sjSOmOcfzXSLfROuxCY+Yge9oHgGws6F/PtpYJba9TnYTSK2ishlpsIhmmYuuj9sU85aT+juL
	BNcYui6wH1Qq93wvs+mtrZp9Jp77wZmk/dcxHLo/EN0Ve7dtYsUHDquvqe3qFloYpnSQ==
X-Received: by 2002:a17:902:e785:b0:2ca:6eca:492f with SMTP id d9443c01a7336-2d64b0e2c7fmr151543345ad.14.1787325084889;
        Fri, 21 Aug 2026 08:11:24 -0700 (PDT)
Received: from Default ([2409:40f4:1002:57cc:6b4b:100d:637b:da22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf10ca5csm27897760eec.17.2026.08.21.08.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 08:11:24 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: gregkh@linuxfoundation.org
Cc: heikki.krogerus@linux.intel.com,
	jeffinphilip14@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mika.westerberg@linux.intel.com,
	stable@vger.kernel.org,
	syzbot+1a01783ea233350598b5@syzkaller.appspotmail.com,
	syzbot+520d7648a0d934061fb0@syzkaller.appspotmail.com
Subject: Re: [PATCH] usb: typec: fix null-pointer-dereference in wcove_typec_probe()
Date: Fri, 21 Aug 2026 20:41:07 +0530
Message-ID: <20260821151107.19945-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026082125-getting-upstroke-a146@gregkh>
References: <2026082125-getting-upstroke-a146@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 21 Aug 2026 17:00:12 +0200, Greg KH wrote:
>How can a platform device NOT have a parent device?  WHat system is this
>broken in?  Why not fix the platform definition properly instead as
>something is really wrong here if this is a "root" platform device as
>that should never happen.

As seen in the Closes: tag, this is a syzbot issue. It used driver_override()
to bind it in an unnatural way. So, I don't think it is possible in a real system.
We could atleast validate pmic like other functions using dev_get_drvdata() or it
could be left alone as is.

Thanks,
Jeffin. 
