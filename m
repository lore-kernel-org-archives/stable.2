Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C2525B2F4
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 15:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784474112; cv=none; b=Ry3wJTRLSotqPzbRWGaU/9EYmR/vn6pgR5kUoiMQvnOpcL2wbB6maPSU90OnU5QDTTCd08V0GgXonjUeCg2XrCN0LP4zpnX2lGCSPDymuP2PaoYZk4gToC3dorLwyGGCaNwL6JFDxbZ0aGNV7WiTdF/auYSYzeqjV74LAy0lsRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784474112; c=relaxed/simple;
	bh=3dPhIGXKwLq7rorj74QybPtMlL++1XGXqZmO8WVRkRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CL/29Fv3fTWdVoA4sNxIKurU2viSZsDt6M7yWTmQ5giDTFQYi8BDdMUzPYud1k+t4Ws2ahu/ci45C+O7VA6pYMgo0nZc3DDAnknD3+OGFU8lLEif7vu1bryIp4YBUe7w9ZveDFi8CfVpnTJSZwf440vFXLzO0NRaY2mA/iAMmxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ow/8DmUg; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ow/8DmUg"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-81dfdbd86d1so56129187b3.1
        for <stable@vger.kernel.org>; Sun, 19 Jul 2026 08:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784474110; x=1785078910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3dPhIGXKwLq7rorj74QybPtMlL++1XGXqZmO8WVRkRw=;
        b=Ow/8DmUgsBsY0YgDi6Vbh+1YnqjdqqzApiN9cLEAoQsKKD3se9rM6ZPjjLKYaGUrQg
         +6JfSq2ZqeEpIIMFMQTaSIAJd912QYeboTFeC+UuzOJIxFDocuwy+fDNky8Z/Z3uVxc+
         TUAHQmQPx8cHC8wK7bu6/VTt8UHzjh1NllX6VAHYkwiWfpbj+byOyI7GSJPfuIxm4p1w
         uSb52KAqEvQ5mXC+/NXrqOAdpygSlVVo8cU6UpAKL4BGnHa1J1nRz5ArI262CVBGJGC1
         KlO1ZA+huGrTSR6TZbWBn+Xe5mXQS4aRA1WeIaHhjh4jsWtUovFT9PxOrmzErnEmZ15H
         S63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784474110; x=1785078910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3dPhIGXKwLq7rorj74QybPtMlL++1XGXqZmO8WVRkRw=;
        b=DCA2yNdWXiTgqtQwTsnoibUSilrVweaxqIEM4R3vrPZw0747XVy8VeTuvgdVjdEnAK
         HdbaNY3pE0ZJ9WR07cxB7DWf0LIyh5KzWsy2XjmomCRdAb3pScNad93vmKfoN0DcWbQ1
         PP4+GA2KsZZow5m50FLKzIt205/a/elVunOOgwR4iO7V+e+LwXD5UiswVp+rq09wuYX5
         7y+9xbcYfiwCUKWiSfdR5lGq4ndvwxBvgnz1syOl+JMxO4qPgyG5goFDHqvZIFTmaLuP
         dEzK0uttzpekgrBFQkTfqYy6mftfgRGgC+zVvhb5vKYKKVLZEcP4XYeM0ahCl+T0dsEr
         wQfQ==
X-Forwarded-Encrypted: i=1; AHgh+RpkK8Kp2hjRrvN95Uc/blafxQrPfe8FgJ5ZEmYfIxscbI1Z+K0ZBuJsj9G1+ZVimj0heDIi3X4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsQGzPtxIdo65KkIYa6XAef3t2DWof8BYZg2U3TKW0msQ7gVzb
	AYU4KYZRA1wgKmerzPhP2vBpsSv9d3uV36VIDAOstlMe+odSPSWaJl9B
X-Gm-Gg: AfdE7cklX83k+54iNpepakFMW6LtZvDyYR7Ub1rLVWsMO4qlOVDbrWcjlZyNYVe52qP
	TlcRyjZ4qqYD2d2nConghM1uZ3Ef7kZfjYtPYx056URbbHcrKicIrJ4ppZriwVF8tfCDLGT6QMT
	TeNHDn/n8tqZ7qg32kDtje1Y6Ica0Zbovwg6r1qV64+WkJ9qhvjvEuNt7rvkkpHsdsqWJkrYhB2
	EYsEKDMUG2+uf127Ly3uSYOW8R0jXaf6EovNm5DlG+9xKGT/Edgs0XhK1GbM8uui/ywnfLjYIo7
	EcGW7gKrqRpXxbFWIgqotvgL/Vs2IqWFp609ivvJ93Hx8D9Mzm+MSo6YdumaDwzwvpYebZ2dAuO
	itCDYZKnd4FPzcEmCBkuwLWy4yB3QQFDgy9fZiuCnRIqlEpLgGgKblwXb2o35tbskqf6zfFD1o1
	A2P9ioD/xQMx419n19BzMJhYZ48VjfRohel2B8eWVhwo3g3Q5vBH0UlgNT8Bt4ytOUrePj6KqS8
	RJkzJnbTx4fnQ==
X-Received: by 2002:a05:690c:6887:b0:81e:c436:c530 with SMTP id 00721157ae682-81ef22d3ec6mr37750817b3.14.1784474110024;
        Sun, 19 Jul 2026 08:15:10 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.f7a5e5c3-cab1-4810-bdbb-207cdd06de9e.globalsecureaccess.local ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ef42f0c31sm41080617b3.48.2026.07.19.08.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 08:15:09 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: oleg@redhat.com
Cc: AutonomousCodeSecurity@microsoft.com,
	akpm@linux-foundation.org,
	avagin@gmail.com,
	blbllhy@gmail.com,
	brauner@kernel.org,
	include@grrlz.net,
	jack@suse.cz,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	mjguzik@gmail.com,
	ptikhomirov@virtuozzo.com,
	stable@vger.kernel.org,
	tgopinath@linux.microsoft.com
Subject: Re: [PATCH v2 2/2] pid: fix cad_pid use-after-free race
Date: Sun, 19 Jul 2026 11:15:08 -0400
Message-ID: <20260719151509.4843-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aluim8REjBcE4ejB@redhat.com>
References: <aluim8REjBcE4ejB@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks, I will drop the get_pid()/put_pid() in v3 and keep the RCU approach.
