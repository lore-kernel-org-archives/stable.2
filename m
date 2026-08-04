Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E21832C957
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 05:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785821776; cv=none; b=qAFOBThFHXvEJtRJuLNDHfJ1cwgOJgSst2w6L6XYg+1kj6TjZ3gD+6tJrN/8QXTSKISNcZ60FHKi67VNZ6pGHzmRmyAR62zwtKfDIq48EXlrmaD8PDsiXvz+7MiaE2VMrPqG7OWp9r6ZT3Dp9vUaa4hvLpcS1T+D0KYZzZPXJfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785821776; c=relaxed/simple;
	bh=uUVoKRdDlnx2bbN6z4zltsxVi/aVw1j//qSChX3LVLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N6NJeM6rkhDDmpHe5EEhOALH2Q8NhbU/EIGKfovv88Rsllu7pUNq8AuhsjySarrz0uCZJSyKgMMIx9Z+BBmWGgfJUh5kzF/6pQvbV7bgvhTfiu+mumMn5sbDytpta6ZAVtnzpaJDlaz5ryBeISYSXao0at5SBSeZjCm4wR8+Dhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3bEgGfF; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3bEgGfF"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4954dff6536so19203905e9.0
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 22:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785821774; x=1786426574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uUVoKRdDlnx2bbN6z4zltsxVi/aVw1j//qSChX3LVLg=;
        b=O3bEgGfFh7uKNeCd/IEzoSNvyLoAx6qPZGu6A0UOD8B7Ftc3H2bfAWCeBlbdoIJvc3
         FREu78sTQD1dkdke1jpcKdnf/zKd7068+PJiSj5WhqdSsoHz9L4XYFEmVkWPNDieVdBm
         tr7eW995LRSwf+wwBNYUb50y+rNQcroVKdfsCU0pS5VQl3HFeiXDk8OVs/HP9kHCwEoX
         r0JHl5PRJIvzVhFxDp/LrKZ3PX3yrm5wn7AI6C+QkkVr/9D5gzOsgQWNLBy3EXxNpIU4
         Q+5yHmRR/zG+trodQF+nu+k/7YZDsSF8jIoD9kQ40PdmN/IyCWeeMfglkfd+KZKdnAl1
         AILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785821774; x=1786426574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uUVoKRdDlnx2bbN6z4zltsxVi/aVw1j//qSChX3LVLg=;
        b=dNneTkDveMU+SElav1oUahXR1bH5Pat7ZEDFKW0IKYIbTjPxi/vuEDK2b7tv91VWpz
         v3whv+Gk9xdF2BaUFyzUc0wNhCbL1fniumcr8+znu2yE7FwiM+rSJE3HG+XIfoiWsBdV
         rtdYkmUfDhrIUslAkCffF2bUiEXbsYoTkkGe+fj1EWky82ax7O9jAjiAH/MCAoJTR1Bg
         HjZmXXE8/tKu9wJvIkRwOLQ2zpMNcjvxjLz0Wqo/enoe3JLp0SLW+1jo218brTTYhvOF
         dEo1GEjIJInE0OadkQAYDB31woLKTMr4VjBj6zTAl+f8OYvdvATLf99XzerwTGfyn/Sk
         qPjQ==
X-Forwarded-Encrypted: i=1; AHgh+RrqsY7yEWKWBBXpF7HiIfiEe18uEFmRPN1fZexY/VMNoeq/SpHAroBNQbqRWm/yukCJwZqNjkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgzrB1zB14S3ibeqjlGCMMeGyaMkTd9KQFIHfsWdpefXGYTzM4
	xL/ZtIKVOT+oQvKffDiALeZEMah8lcHJe76gvpD2tVZJkEiNL4GS10Uk
X-Gm-Gg: AR+sD10ZzBEPlHMCLrdRdBRMx4N9ge5cKTBolLrsKGbkS+AJNlC0Ui/ci9hGnkJ0qit
	ZfwpdDICejc8qJOHpDLBp7PU4oCzt8SS5PlQxuUb9aAMU0fn95ADgt4IAkhTpS8QKSoeMij7ziM
	sfqxcYvBO0f7J2hH8lQ2opUG0SS+CQhrYL6dTOCpsqhSOd2RuTJvi/J6kGKq4Ui6sIODQPfKRnP
	uY1wmhMIdSurLt/F2QpQ00j5ySc+uAGO6gyH2+TW2KshegSJxJEwVBKMmq4BQHWu1VfHEoSdcie
	k2sKKD1j4oSmKGq1eMsSHgmU912IUdUekIoHVnVEF50cFEncCC94a8ZF/hs+oyn8HFFki9yAfzj
	rrsYUic5mEZiu7aiAMlUaT+xzVcdEnBOCgjZa8RiyPYWx84tDjs0W/wdHaLZdSB65yBsOptkKEM
	9LZ+rSZ7g0Uripxyn+rGwzeIuScedCedXRoZbLzx1o3xJUpMVP6tjqAkVfrE9v5XbIK/s=
X-Received: by 2002:a05:600c:154b:b0:499:49a6:4388 with SMTP id 5b1f17b1804b1-49949a643f9mr61634265e9.17.1785821773878;
        Mon, 03 Aug 2026 22:36:13 -0700 (PDT)
Received: from grower.astralinux.ru ([81.9.21.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994a0fca55sm58641705e9.13.2026.08.03.22.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 22:36:13 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: sashal@kernel.org,
	lvc-project@linuxtesting.org
Cc: alexevgmart@gmail.com,
	davem@davemloft.net,
	gregkh@linuxfoundation.org,
	gustavo.padovan@collabora.co.uk,
	johan.hedberg@gmail.com,
	kuba@kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	luiz.von.dentz@intel.com,
	marcel@holtmann.org,
	netdev@vger.kernel.org,
	oss@fourdim.xyz,
	stable@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 5.10/5.15] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
Date: Tue,  4 Aug 2026 08:35:55 +0300
Message-ID: <20260804053555.945430-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803203505.stable-0006@kernel.org>
References: <20260803203505.stable-0006@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Did you even build test this?

Yes, i did.
