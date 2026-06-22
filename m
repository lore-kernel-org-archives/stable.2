Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82F23B5F59
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 13:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782136727; cv=none; b=eOBY2RpLFV+HILfYyG+QaVACSLUblSBx+M5ZH4MUmfV4AQz/ypqkqQgBoZiIbF7Zk+thqGplqBp+xqHtGT110hOpzBerjEvoDrfvsDa6AVzMJHaHIkGbtVCpJAIwUTGP4Fj9svcELAQDcjAtIf3kd2MVUw5fxCOgq7l7paXqQEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782136727; c=relaxed/simple;
	bh=F2YVYUXSYaBRv5EuPpzQlID5z4oH0xM0C3Ad7xeAKGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kHWZuWVGFAFtI7+OzoJy85BaYuYrqttdbGiJA48Lmw2DhrGhln6kqWpxEpkSg4a5blod1PiMhE4/HuYBdkcT4Ik2VcNDOkF9VTNDtmaR9Xc92cr5BNgxqHI0Urd4jV6VZcaA+jZbiu/CmbwSlbp6cav+oqDxy351ZJ1UT8auEGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbH1VXKe; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbH1VXKe"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6870ad8072eso7041004a12.0
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 06:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782136724; x=1782741524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2YVYUXSYaBRv5EuPpzQlID5z4oH0xM0C3Ad7xeAKGU=;
        b=nbH1VXKedQA3kX7XPNt85mRKNZQyR5gUWsnmACFGmvrr4uGVIskrxLRbImeC75US5z
         v/dQqtd52uke5mAwjiab/H30Yi5e0Lg1PKsuMiz0p223dX/0aayzEMFP7Y34SxUg4mwS
         xOqI80ljzBKo0dLaGUQYxeJQB9hDboju7bFTPgEfHfdDrMPC+Gob6J4oVgmqFP9EaijM
         oW3I5vFLAdEbnOM2yyrmOeJ2YY71fwFpHGW7B9+HMzo6M/5b9Hgu2gReF7rs+gkc89YS
         A+wd3ODH1D/9iFF+wRiIHzQvnhWlsQU8N3BP3bmm/lmuPNkJE8RZ0qzpXQkjeUQfAJeX
         AFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782136724; x=1782741524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F2YVYUXSYaBRv5EuPpzQlID5z4oH0xM0C3Ad7xeAKGU=;
        b=Rc8gGaX2nv8WjUC3QQbtxob7zROjjxMdxBjqw/G/z+4z/7j2R4d1UozvoZz65orvqn
         csxIkH39zpA7Qy8Hpwz3++VSwf1oreXKMgv/DbCmPp90qEpiUFjgsu5ACheu6uERDAIp
         dQ5D/dZN6CT8ZcmAAGYVb72Dit1JBYXjOjvAfQN/u3AL1r/mkl7j5nUXtwXrHry7GrFr
         QCj7g/U3FxLBmIfHyhsvN8nR6D5sZbtUgYNdDQOeQGAmdUtSEq60wFM5+pCCiIQLM7cN
         TggqvFSxbjRhMADbXyePd+JTBzXwmJiM5XUsia0a45rt57iadZ84m5AxQ5jhF69Bhxf1
         UiCw==
X-Forwarded-Encrypted: i=1; AFNElJ+uMaBTteiMvLczC4AvKw/0RrGLKVW2kmqhjqAp3Fy8vsyJUmbXmPoRFEPcjxQ9U4uF5OlEzHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPZZpK3Gp+XyWu/MOA2XPBVhcCSGapIc8/qnAsbHfqqO8vBQVF
	I5lXyDXGqlI41LKBS+qDd5WXXZY6OdfRJJvAkccJRDrG+xnlI6Ov39fe
X-Gm-Gg: AfdE7cmPXEVhnqUcnJeFsReGYjy3+lwmj2ejItZnoCrjCgfuX3AlkorY+kmE+feQ8VW
	xgYxxUCXWwkKMQGQcEgbKxlz+4l3GduiI8Jo2I5vwKaQVbrJTyjXFEgc13+aOcZ8CtghL3TIv6i
	J8LJsiQNsv9Y6fo20ck0R1B9JaPmULzk+PFf4BeLJVUACC6zlaHeXNXUcrs4sWIb7x3yU7NeP6Q
	hs3xrHSsYcR/gWv4yzDg50dn04PC6NViQQ8aJfGv8g2XsNPtkbiGlHeoqxJ8g3iO4A95LRymvU4
	K6K9YftErY8IeZL46qjJEijPlXZjETyZ+Xc8wEQVK3jXskQ1rf486SWgYnuM5IBrZaGXVLBvbs8
	3nwz2qvwx3xPnNyHV6lLM+K6M9VF4fzfB0XIDSveHnZkiely9a/Ha4SGaRdyKDfliy4bc2UuzSi
	1mLVWBEBZrrnISVEg63s7dTkIQqf1doNZy8NOiin20btu7ngq7mdw4pwx7SopU3YU=
X-Received: by 2002:a05:6402:5288:b0:68b:ca3c:6bbb with SMTP id 4fb4d7f45d1cf-6973bcaa247mr6412241a12.11.1782136724049;
        Mon, 22 Jun 2026 06:58:44 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6977be64ddasm3156308a12.28.2026.06.22.06.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 06:58:43 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: david@ixit.cz
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	oe-linux-nfc@lists.linux.dev,
	horms@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net 0/2] nfc: llcp: fix OOB reads and integer bugs in TLV parsers
Date: Mon, 22 Jun 2026 18:58:28 +0500
Message-ID: <20260622135828.241486-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <78e283f0-1493-4d72-92fe-e6444458fb91@ixit.cz>
References: <78e283f0-1493-4d72-92fe-e6444458fb91@ixit.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Jun 21, 2026 at 09:52 PM David Heidelberg wrote:
> could I ask for the patches rebase against for-next?

Hi David,

Rebased onto nfc/for-next.

v2 is now sent and available here:
https://lore.kernel.org/netdev/20260622131802.239035-1-meatuni001@gmail.com/

Patch 2/2 was dropped because the equivalent fixes for nfc_llcp_recv_snl()
were already merged (ed85d4cbbfaa), so only llcp_commands.c remains.

Thanks,
Muhammad Bilal
