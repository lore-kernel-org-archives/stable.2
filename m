Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCC737BE72
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 14:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788792021; cv=none; b=l0XsqknbnApFqv7WT9tcp2mjJEiGsro/8gWm7ZHvUry8n9G+CeAypwW4uPeYK+Gf49GtnsbFdKhQi05aKZc6vQotf0QhPG11DTVM3ExN8yDOHz9HlRCHm6OkJGYj8ziIIjhnKByCxRr3gUTJ8Zq0m/TKpW5bPvs4Kcy3b12MoIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788792021; c=relaxed/simple;
	bh=3riO5LF0LDQ75LkWbWV2i4SFadXEYv5vGvj8f2UtOgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jf336irNxsU6I+LJZJSPcZQ3nNJaNiWxsK7aI6q7PQbJVAUMQbR6Se3YQmvejw9dqRJLTXK77Ruw7tA/vEc8tiBz7NOzWS5Tz90hqAkQoLdej0Z1HLcQ5X25SjpSS4uoqoWxJfgwOaWM4wTRRA5OCOflp8Vv5TJASBP+StudWA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqB14JF9; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqB14JF9"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a0794669a6so5370735a12.2
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 07:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788792017; x=1789396817; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RuGYW3h9PJYNaiCjKHB/faSczvFn9W4fzqCSPNsruxY=;
        b=BqB14JF9/W2J7fnwtvAf0q2KWeZfVojpXybY8rR6XB9tKuf+jf34UQVVi3/H1SFdjk
         Rjqppb7y/tlBAcNLyAgBAGNI2w+YX3dlcR5L2PtXJk0t8EEQEp1n6HMt2gSFnsvIXaPq
         E4CjgHoWIek3PPxn0ksEZmbbR+RlRQOKU39dzxn9wZunhhHd0nqUqxamjrzvxFal4uZL
         6hAD1fpHeAzqyNUDA2enUDtK/VhmVtvqHAL9Ku3aMeuwELSilVzmpAYZa/Tu6nTs4q+3
         BxEaB6nSFaKJzJGG2jtUci1YNQeqMqjDpF7YnzS81cPa5lCbHJVjER6rSD0FOBhbSPGh
         jDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788792017; x=1789396817;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RuGYW3h9PJYNaiCjKHB/faSczvFn9W4fzqCSPNsruxY=;
        b=cFR/8dLjSgt7lx53UEOZ9S0yUBZt7/kH3mUHT4DVzTwiE2uLkm5kFri03KstzB+gGs
         cqEu8nd8hgBVep4tkTgsCnHkcw3Hnn3+2wBNwEgCMztI8TinA93keN0gcnu5BPrcIcCZ
         28SzULt9Sv/zFIanWR4Jr3tcEGxh+fong1vfrvh2RuoRIJtVzvUtRKnkISX60oiNhTZO
         SWPVs2bZIQRuljLipIWXLnG6jWDfpeICOmt7NrQdkmHieGkVZ/Ful+s16NSW0R/+4EkQ
         4mKKjkQEbPB1A+2qJ8YhL57jBW2Itz1ceCHRaBcEA666fwCB4Y8/kFoB3lJePvka61Px
         Bygg==
X-Gm-Message-State: AFuF++lHQbZ6joU8WvpIEMRhSQAVpBe0XGcWN5gqS054gOZoVX1UlSpt
	dlR558BSw82JCKKw196gMTwuq0pXjsdQmrtwh5B0YFtspwgkeANdCFbyhC6tKeRc
X-Gm-Gg: AYBFou1z3tssz/xQRZVLEAuhMjPJFYCf9m3wYvZWvg21dLZZTnsU27PBYnZL8Nggixe
	8pfIC0olb0nOWMkFQb2zHeaAfMFGmIY7lTFyUhEn+1hGXIrq+glqKBXGas2zJzBMdeoTthqpDCx
	hRZv3alJTldiQ5LTh+shMV3TfsYXaRajUuXfiIpH+XtT4JCIofopCmZqDTkn+KoPG5bwcQDbnv9
	fGsVqkC5V2KLF9AxKKp5+QenfJGkpoSOQ89RhBzB+CQCGp4wGlUG7nYgWPcnbaxsi/IUW4s8LWb
	KtnF9sUeH1UO6lMhYs5+Au55YdQQZoBXg0Z/S6J4dwYgLMg4kbp7u8E3QG2ec4sAMUZ6sed1YXn
	cPnCff3WKlPmAv2EUrOnBC0ir9RKMAK6ivupL9KjhiIrxmzFnnzCvoZ6NnVZzYcz4HDox+fqvX3
	oXUAB1pGlSFL9d8DdVHtAytC//jkKvQXA/MsW8xT6jjfw0H/LzygoO4a99U6pjqoA9XaqfFTI=
X-Received: by 2002:a05:6402:3706:b0:6a6:7818:b18 with SMTP id 4fb4d7f45d1cf-6a7e90a9981mr8187671a12.22.1788792016878;
        Mon, 07 Sep 2026 07:40:16 -0700 (PDT)
Received: from grower.astralinux.ru ([82.22.172.205])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e6c20a41sm4438279a12.31.2026.09.07.07.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 07:40:16 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Martyniuk <alexevgmart@gmail.com>,
	lvc-project@linuxtesting.org,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Eric Paris <eparis@parisplace.org>,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.10/5.15/6.1 0/2] selinux: reject an unclaimed class value in security_get_classes()
Date: Mon,  7 Sep 2026 17:39:53 +0300
Message-ID: <20260907144009.162239-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Backport fix for CVE-2026-80912.

Bryam Vargas (1):
  selinux: reject an unclaimed class value in security_get_classes()

Christian Göttsche (1):
  selinux: avoid implicit conversions in services code

 security/selinux/include/security.h |  4 +--
 security/selinux/selinuxfs.c        |  7 +++--
 security/selinux/ss/services.c      | 45 +++++++++++++++++++----------
 3 files changed, 36 insertions(+), 20 deletions(-)

-- 
2.43.0

