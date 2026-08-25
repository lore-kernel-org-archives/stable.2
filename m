Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5E4394EBD
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 10:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654253; cv=none; b=YdbEIjD3d/IBnJXJ7WqRkp8PAWdb2BGP7XWmEfcEX8P60AJAY+JlfEsCfdAk5NqZLWWhVOCXxRCH/12d5caTEKtSm9QBE4/z49VHHYoqMWMWGX6MuJHePUZAiwm5b7FZ970R5cevun+ouE2hC4miVB4E5EjKoPllXcn/2XRDnkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654253; c=relaxed/simple;
	bh=PwCVLPMGiYvP966qlBCxxiOxMIsGutesFDlsKAGQOjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GyyikH3MJVBpuwsE5PCkpNu6oAcSHDq8cj3JjGbhr/04R2DeJciPwmsBQkPvAKFUQ0TCgxyIiNJzp3+HUxzstpORxHwaseRTWT+gOh7So6etgr0UMBX5J0sQ8joWTeGhcypKDcz1qUyEfzLgsJ2eHN8oWTfQuAu+NbkSdhMMtGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ER/d44dE; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ER/d44dE"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so4137536a91.2
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 03:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787654251; x=1788259051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dQgF77Mzfzvw01A6ShvT5BIDqsmlEOtbGFu9IoW3TwY=;
        b=ER/d44dENyq4EWVbWCGgHpxoFAy4BqjeGHQd+uZnHruVOAJY5ucVnBFlGZ/dxCwPMG
         YN092ncqWl4uqcVkm0b0zSqABvKpFk71NhdmtpE/M6sCdV0m/L72sLetrjTlmR6r8OTI
         DVMBPuoOoEIvX4lCh5YiDWwz0iSqVYZDhHDut7+gOJR6XZBBBNNaROmA6p9lFr10ejr4
         +sWNcmwPWNwY7qKcLbzvEtAQDBgb20By6+2+Fv3tjypP1izghAY/Wi1wq016NpwdfTqu
         X6MK77YoX1SERW9FeXE7C8CTED3YppQM+FIkU05qXI9BsnC2KPGrKBVyj6HQRfaDb+sE
         Avhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787654251; x=1788259051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dQgF77Mzfzvw01A6ShvT5BIDqsmlEOtbGFu9IoW3TwY=;
        b=OF/Zr/zEA2wXA9o419FBm4MZz3stGWuGmUlCq8AD2P12xcN1ge5s/zH9B2Mmc0+Nrj
         g9ZdFYZnABW44SnGo/K+VCleuvso2mrY7IoULOdGJbzCYsJz/lddESG+EMXXX8BzL7Ox
         nhWjyLNh/CY0FDlSmQdNwwHOyoBkvyVAiPsJHGosp73MN6Zma/0A9yH7lsBvUvZ/ApZk
         R5LYxs1HRBwpQWEuk94jq9i44o9t8nNy9FDpet73LW/A6v0ZkkyEunxv1Ebp1t7aXwnh
         WQqiVAIi3PdbiL9O6cZuW3you/dcPxOyvI/grlk1lV6MBRXYXZ9KQVLtZ06Ug2pd7vZq
         vEQw==
X-Forwarded-Encrypted: i=1; AHgh+RqxK/2M/PIDOZnXF+/iQ8EILCbbg6iXAWpfP8GQBg4p0eKwwWqVXyq7/HzyL/CB/MoFewxV1lE=@vger.kernel.org
X-Gm-Message-State: AFuF++nIBXrJxncesBOlhLWiUFf5rB5cOLU3PCmKzMMzcmyijQvsKAGk
	jKOIbbhyT0dXTc/66JDfN+661IK33w0/jl3u/NRWzZW5sasp/tOe11/t
X-Gm-Gg: AR+sD12gg3YznHlC/igMyg6++Zrye0Qc3GbgWqOqY4dMW+3lzGuWc/EKYqOujMoU9Kb
	XZVr1sD0Am6LR3SKseZf3W/0SuVFwDaPnu+3+vU48wHx4gg2gW2sDb+oxLU+Hx+lWB4kCRTAaSR
	ZVtTFg17E99WMu3aC0yyEGzjHiAlPgYFv9bBuAnbO16U/jnP3fo5hVzz/Hm7wXANtQaFP6fAU6a
	sEMSIdHL7gQMKRjttc8fJYAiDG55l7ebV5xvkT7Uj41ZMOD6K1C6nONSvOy3Vw50JSEd8wl01nv
	6iBREVRC2PjoCXy3z+aHN4jDlTi7jGEkbp6P2e1+WEVGpR6jg9ficVuFExPwptVBkrRvWQUQgug
	ARy5ROIP7oEJOAf9c3JClLZ8MMBL+KWnXcE4bkzjcPWfZ0lq5/Iwn3WTb8ij1WLx1xNB5jAlSTG
	QwhSPstS6CIvMt5zLB6fk/+LTtHRlgnnE9OpybEM4dVd/dJxb6OraRl3tKNYvx5rwH8xkVQOTgi
	aCSmDhlmXvbIByRBAABiEz1HFSONIQK2BE4/4rUsOnFQ6j0oxCgupqcbhLiukDf5FIbn8C1l8gI
	CdwwYzDyL3k2K4uRMYfWkWMI
X-Received: by 2002:a17:90b:3a08:b0:38f:efed:5448 with SMTP id 98e67ed59e1d1-396463b4454mr11748606a91.8.1787654250829;
        Tue, 25 Aug 2026 03:37:30 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f91d33dcsm46097533eec.18.2026.08.25.03.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:37:30 -0700 (PDT)
From: Wei Jie LAW <98lawweijie@gmail.com>
To: 98lawweijie@gmail.com,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: aduggan@synaptics.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] HID: rmi: fix OOB access with undersized RMI reports
Date: Tue, 25 Aug 2026 18:37:24 +0800
Message-ID: <20260825103724.13820-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825060954.104890-1-98lawweijie@gmail.com>
References: <20260825060954.104890-1-98lawweijie@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Jie Law <98lawweijie@gmail.com>

Superseded by v5:
https://lore.kernel.org/linux-input/20260825103117.12180-1-98lawweijie@gmail.com/

Please use that one instead.  The only difference is the Assisted-by
tags that Documentation/process/coding-assistants.rst asks for -- AI
tools were used in finding and fixing this bug and I should have
acknowledged that in the earlier postings -- plus a trim of the commit
message.  The diff is unchanged from v4.

Please mark this one superseded.

Thanks, and sorry for the noise,
Wei Jie
