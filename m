Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794569056;
	b=oAzwO2wCNzWljOIhrhTj6H0GzW7gwVWg9X/D23MwD6HjFw6nLNqhvSQlHkbMCLVM0h79
	 ZdW7zuJPzVQ492pXPDavMFdEAFV+Q3ODqB7Mbi1eEmfR7rNI57YuidjmkzNS9025+d75M
	 N6VGNnBAJE9GncITeYP4WLyLs9osWT/8OmOHQ6oN6KqOLhytSqAHfPv8hddLg4osEI5vi
	 HvIEtQ+5VzE14kc++e0pReCv9z0eIKTvG77yGURYSP9/FtJMPKK7qj8oK+ZBapl2ZGBCs
	 uPwT7z8rNcP1b+kx3YGOS9CN/DugyJcGza7nQBmpukzQ4+OZ2bwT2HFiru4oSIezDxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794569056;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=A2z7Tw5DHCFD+mcx9gw6v8Y1X48/h954fhMI36CiU8A=;
	b=ha1M2ldp0Jwg6cB+q0Ul6wQe8lR7NDFflb1D0+SuA7Lezt1WWyPDY+/g7x5WtDic6fC7
	 kbSmzwhm6++Pr7w5z5Fezx590B8gFK7/oSgmPah5zc4VYrVHX//l5mtexFzZ64/BIcMrJ
	 fePdNvYGeIHXkfiU35ckRMdVROiETK4ky1QT/po+Pbdg9gEL7J9gXQ6VQ0MlHWoYfiCel
	 hp2/qMpQBVLNzbORqgjOASBYWWhvlKPmYrxQ4IP3odxM/L66RGgipCa0exJdZTkL9UWHR
	 LXM5xCEGk78QNzOGVgRZqtazex2jTtJYWr0qpwdE0igk6o9qzlzEeDDUbWX3g5sOQEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0XKB7toi;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E981606A32A
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 11:24:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E981606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0XKB7toi
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-37000e7234bso428607eec.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 03:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794569055; x=1795173855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A2z7Tw5DHCFD+mcx9gw6v8Y1X48/h954fhMI36CiU8A=;
        b=0XKB7toibmTif2MEATU8EZggVXApNKF5tJbXh7MpZRZKyI4pE7FaNOUowZOCzwzkVy
         S1NwmO7Y+wY60fXBsK5t/EkC1UBC6B0TnOgyqZDTBdhgJNn74YVQEC4qvH54McRUvSfR
         YGd99C+Wv57zzyMJnGyEJgUjGiRNCqR0/ic8VGHJD4R/ojC4IhQ+lhm7DqaCQ1MjJIEb
         AFrHb1RqjZ+0ikSTu5WI5sdS+7At98IO0TNPUr1dUBxQxdeQDmGM9fH/H+iKtkxdSdc/
         f/9tJKHqkV+Vruy7ktloYUz6MVlJH4aiHHGPUgQKf4IWWhIkNEg0qTuw3r5AqZQVW4Mm
         /Mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794569055; x=1795173855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A2z7Tw5DHCFD+mcx9gw6v8Y1X48/h954fhMI36CiU8A=;
        b=f08dzolAnrkFmS/eu3R0ada8Jn6uP0mZ/VWgAgOJ8UwV1/S6H1X6ovOFXvSw5k6B0W
         BDN/PnWTAgL6shSoS9famxEEUw5hLpmp0Kroahh9lIvMz7oJuEF2e5Oq7Hbj5sUjRh+A
         BcZ5PaZC6xH2Pz/v/sobzwYmZj5xrkMImX/Nn+XiVbHRADkEkfkJ/ImwWl48NjnezUZK
         yKU89rXZ9FLFhCSwgN2xqVdBLTk0OP7v0QyZ0Fj2QbEWU6m+qGXb4rTMVPUUCuPA2AG5
         E5EG0tw8XKacuT/9Z90bbmSXn0Fz/Xhhi4MwPGSqOrdbdySF84t/W6TnpX38QmPz9Kv/
         U4tQ==
X-Forwarded-Encrypted: i=1; AL+hErGj4WKcHRLcwi/pmrlKOsH4lEh0nfmAoGZXl5THKygoNCY58tiCf+RVrAfDO2vWF2FdKdfP5U0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/cRFLH2uI5PkKfka8DP+IntyOY5gqImHP8EwuFcACVymha/8PJ
	k/3NOmw3z9LgghLQ87zMqmXH7uFySVKNeT5DrvIJVC/FdNRikuOlU8Mt
X-Gm-Gg: AYBFou3h8R6xxpwQrybZuXKaZH8rUk7VxNJ5bZN6ABvJQqCgboOHVWyre1qpCPTeeQD
	d1YKL/th+As33PguPci6dq54OExUkxLL0dQPeZgqUSPkG0fvUkMWxa6Z1QLSQyhr/dMXoPx/nzA
	Y/Qr/Foduutv1jZ3HLoBj0dZia9AADWZxb45aNfX0lESSzrSe8aTAQTCc6zOaRMQjqnuCWsH6bL
	8UqIn6ZTyBZKD3TafH4yH2j5ReOu1kp8LxM8Co1PW84QoIUWhgcwLXR2oeuOGqFxb0v1INDB3fq
	60FzS9HkOEbpyPIVH0AHrmj6KBljXzQpi9cgZAmnXfptCLYdtAdvFutQnOxD4+glFfylUn7+1LI
	1AsvJkFrh6t4y3a6vABVi52DCnIqDTFQhWLErrP3n9XC4/R3YeUFA4Habo1kn3NSsKI5GLcB7Vr
	QTX37EdLekmiQyYXAXxOFJsROfdStlZjdIyQZdEElBRS8nFdpIciKzRGKo2jmK/BiLW+f4pBO7d
	uQZWfnGBdPLKRF/x7sAe909ZikXXhUcpO23s7g2KXoZduJ/ftCexKVN75Fu0nNg37KZexU6YeIV
	bLXo7u+1gbwYnoqVgvA7lKtLnXJLietanVUazM98fIq7dw==
X-Received: by 2002:a05:7301:2024:b0:36a:18e2:64c with SMTP id 5a478bee46e88-379655d3d12mr2185384eec.11.1794569055067;
        Fri, 13 Nov 2026 03:24:15 -0800 (PST)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3797f98b9b2sm6771786eec.6.2026.11.13.03.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 03:24:12 -0800 (PST)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: mhocko@suse.com
Cc: tj@kernel.org,
	akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	penguin-kernel@i-love.sakura.ne.jp,
	mkoutny@suse.com,
	chris@chrisdown.name,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	zhanxusheng@xiaomi.com
Subject: Re: [PATCH] mm: memcontrol: don't miss processes whose leader has exited in OOM scans
Date: Fri, 13 Nov 2026 19:24:05 +0800
Message-ID: <20261113112405.1583476-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <avbIL86R61Lu2YVF@tiehlicka>
References: <avbIL86R61Lu2YVF@tiehlicka>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Michal,

On Fri, Nov 13, 2026 at 09:19:59AM +0100, Michal Hocko wrote:
> Do we have any conclusion on this?

No, Tejun has not commented.

The same case has come up for cgroup.kill since then.  da13e0e72a73
("cgroup: fix cgroup.kill for exited thread group leader") in the
cgroup tree handles it by walking all threads instead of the leaders,
and leaves migration as it is.  v2 does the same for the memcg scan,
so I would continue with it.  Chris's "mm: memcontrol: Don't lose track
of exiting OOM victims" changes the same css_task_iter_start() call,
so v3 will be on top of it.

Tejun, if the exited leader should rather be moved along with its
threads, this patch is not needed.

Thanks,
Zhan Xusheng
