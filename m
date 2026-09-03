Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6770F4EA366
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 16:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788451871; cv=none; b=unbF5Wi5+gdf3ywdy1h7og/eEp3Ucn7PE0rygR7Mfhtyxhs+/6TowSJFrD1nVmwVvRSB8oZTcwWYGmyO6EmhwQPD6C9YW+42ukVZ3s0c67I5t0T2UrK21heoeJ1+JQ7ztitYjMguTpR+cEPGL8B9/OdULCaABlePKAhmQv8g0k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788451871; c=relaxed/simple;
	bh=7y/YeoTdXNEh7ZIpzOeizOv9NA3RBjXR7PfihMVPEKg=;
	h=From:To:Cc:Date:Message-ID:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SDxQs7KoHhIKA0iZUzMqTWUNiBjjf/iwl19BRHhCGAj6pGrNTyXX2Vzbj/vo+1nUCTb3wyItxH6RySe4WZudt7iH/88MM5yDgPFtcnmsBBHC6HycjmH1TySihCrw47p+9b+1B527WfC9lRfTx1xVd3BrSBMdP1X0v3oTWH0VFn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cwd8MJWd; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cwd8MJWd"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4957952e0f8so36345e9.2
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 09:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788451867; x=1789056667; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:message-id:date:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7y/YeoTdXNEh7ZIpzOeizOv9NA3RBjXR7PfihMVPEKg=;
        b=Cwd8MJWdTEEflS7XpYwyUTv54T8ivJzvjnnodfAddd1WcBSisGm72bFgXAaAiNHNKN
         F2X0Ruj5KZiytn1LNfNJZCGFYTrsfb54CyJmUYFvVmZV18VhRPuRbFhJP4PBy4WpoXXT
         u9VkHJFur7Q8HO+BK4D1mQA7ya/xlJ0si58hI/T78Wp6EbEzQrSo99xe+dJqOyixdZd1
         jLSHUvB+RWbGokdXWOqYcozpap282KKDwyxBQ2KWlQ3lRBQBkEJBKaJ9e0jpfmD8EWjw
         dFVKNImShvCASqTZ+uPaVGhb+NcPDdilY39Y04ju0PMVJGCuT7wca28yjGQudVLYu60L
         yOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788451867; x=1789056667;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:message-id:date:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7y/YeoTdXNEh7ZIpzOeizOv9NA3RBjXR7PfihMVPEKg=;
        b=dhcdJzMHHPxeVRd/OTnBNiRukcUXQQpejeHc6LJ+IftZYpKBy2W+u8DB7rcyDBA9QH
         QWjAm3Ug5tipqXlZCi82FVgKI9krSZvsYvqQvyJo00y7DsIlaNAZ/fmm+WhSVBoCQRM/
         QHv3HvuaRroX/6LBojBNbnzSCPr7oOqYuUhHsTBzxqHVx8/mHVlKA8t+iFtCIeyCxfog
         fw43H5IINxVHmmjoBziUXSQq7mD3tlc218OcpiYLzPN//tFHY87/U8g82g5J6dq0AX+O
         2Ry9Vzvpa5HrKM7Arw1FoxQDXBgwV8qf6CNCZ54n0o46d8czPPm7MGourq7YSAaKzfz5
         TMvA==
X-Gm-Message-State: AFuF++nK9SiJYSc9HY2ztDKqQabgVRTv0Wn5YICmD3LRmVxhs+tuseRp
	mP4784xt9S7MVjwh8OYHLmZglugAn80zQYrHp8qMymDiQb9ERJQGpkf6WAlw7myM1wI=
X-Gm-Gg: AYBFou10bUYlmokho540nc61zcJDF2UeCLQd0b4+HxdiJGzyOBaPxr9lnWI0ftX9nW8
	Fml2nqnuCA1bApbeBI/CdeO7EUg4FI2YMIQ2XfSi5axj1dcysW6n8x2tZFBjPGGE3S4B1hY8VXZ
	LVM9dxMGrJnXmFjjheEw4KCr+TzOHKSbHpDR7FtwcB1aW8zYf/Reaep983akscpZoUhriRd7ufz
	ZJc9KUuNGUbu5r+DwA5if5dHG4q1dzIPuc7dWZsB4lImzSpjzuoiQ1v5Y3GgzaIF3ULwzdqow+l
	ehVX94qx1BRwYYO0R+dgEBpDu3GqzpYQwAmt5RTpwR++ubuQaL/oZXLBAPf1q6cUHNF1TpnpYoa
	SvUIH6DWCAT0vaGWFpxW/wLxphD9YPrfP05swavsRHaohjIAfUnxGo/x2pcpGaQP8bxdeJl0A2Y
	6dFrScgRmz9HgWPeaf8QSoQgwv858Ror67qrjNj5pkhk5zuVXYEV5MEg2OVg8Kn13pRse6MC/TU
	LgaIoo1Mf3i44sTdz5z94ImNaL86Obvaogx3HhGKeaofzAdJ9T5ZqvVbjXctaNRZBN4T5J5e6fJ
	b8Wd8Z+KGrVdY72SeKa2g4iiI6K9CXNr/A==
X-Received: by 2002:a05:600c:5253:b0:49b:916a:e553 with SMTP id 5b1f17b1804b1-49ce558f53amr119012195e9.0.1788451867490;
        Thu, 03 Sep 2026 09:11:07 -0700 (PDT)
Received: from [192.168.1.144] (98.102.222.87.dynamic.jazztel.es. [87.222.102.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf2abe1basm49686565e9.10.2026.09.03.09.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 09:11:06 -0700 (PDT)
From: Miguel Garcia <miguelgarciaroman8@gmail.com>
To: stable@vger.kernel.org
Cc: pvmohammedanees2003@gmail.com, akpm@linux-foundation.org,
 joseph.qi@linux.alibaba.com, mark@fasheh.com, jlbec@evilplan.org,
 ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Thu, 03 Sep 2026 18:11:04 +0200
Message-ID: <178845186455.1865019.13911237622799207209@gmail.com>
Subject: Re: [PATCH 5.15.y] ocfs2: fix deadlock in ocfs2_get_system_file_inode
In-Reply-To: <20260903152435.1801594-1-miguelgarciaroman8@gmail.com>
References: <20260903152435.1801594-1-miguelgarciaroman8@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Please drop this patch. This branch already contains acd5768c7363, a backport=
 of upstream f5b1910e23f1 that removes system_file_mutex and fixes the lock i=
nversion. The older trylock change is unnecessary and can cause failed direct=
ory lookups. Sorry for the noise.
