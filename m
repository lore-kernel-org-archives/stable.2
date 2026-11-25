Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795644396;
	b=JuqJ/d/q0k6IKTsHU5mpBoQk6fjsw1kWx8jeXoZiOH8H2xuGu9FpEmLk+wJmKDVrmvqI
	 wglzllm4o1bOCnkZ5+033ccwXV5YE3gX2FYfV1Vwd8sC9/8PwLWJAdaQCMOVZh7Md5TPX
	 Q33ufYOSpgdLw6knb3BP52WfGVqYEn9l0mtC9f5c9o79/ym2njpquTcAbZHr2K4ayfvsO
	 T/g63M7n7rvDND5+WL9/mAgtCW0foOtOlLRWZkNfq4PWSZc8gKlTVlKTnD2nL1xv8kg/v
	 PjTPcuGogT9q6y88hY6a/ko2pLjps+IOGzUjEEr6+Fxi29LfgzXdXgHirk50QiZP9Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795644396;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:From:To:
	 Subject:X-Mailer;
	bh=YLae1N0kg2wg3olCT+catsqeX0HY/gzgAbC24mD6VL0=;
	b=DRVfyo9AP7KalgzdKQWI3XNLA29HedFptjGr4WdtBwRJCYXQmuvlYGCAWhtCYIlqUZC4
	 WdrYZ2JDxc4l2VKF2Q6dh5HlkX61PUAbBEDxG11hZGn6SlzJpIfQEu4KDRrbopqQMeqRx
	 TFBYEwAosSUunv1vxJ1jRwxgyJXLJ57eu9p9SRk5ByVI7Diw33vmo+UNo8JG0x+cUbWU/
	 5wpT2NNoOm+DumPkxt5xEtRiyCEuPpXw/JzlI4gHeUgdVdznD19yUIQQSD9H8cJT4PBqc
	 nHiy0gQWT5eo/3Q9AoPy1tDEPjb6ZDL1qLXU3BuxRwE5dwoWTo+6YjoG4k7UEyQtmkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=okonski.org;
	spf=none smtp.mailfrom=okonski.org;
	dkim=pass header.d=okonski-org.20260707.gappssmtp.com header.i=@okonski-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=FCfU+FEb;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A38606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 22:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20A38606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=okonski.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=okonski.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=okonski-org.20260707.gappssmtp.com header.i=@okonski-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=FCfU+FEb
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c5118deebcfso949687566b.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=okonski-org.20260707.gappssmtp.com; s=20260707; t=1795644394; x=1796249194; darn=vger.kernel.org;
        h=subject:to:from:cc:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YLae1N0kg2wg3olCT+catsqeX0HY/gzgAbC24mD6VL0=;
        b=FCfU+FEbdrMdXCqbFQW/6oI2abE3i7ImxenbOyMw5k8ccPO1YDekAKWicuWxIuI7xj
         zYn3iWxe1Zca4+itFah9bGe2rl1ETHdTx/FXA43DUneC9GWbLOKLaQ39nIbK0ijeuWKc
         jgjIztE+Fdwv2usm7SHf2F5qJVLlMota+Whv5epYTWtVnA154kbUCtYg3TCzYmYE1ouW
         3SvHCTnhbkeV+rY6smqAOeD+LvW9NwByLhgKmmikilQR7dMexKg6DdGVKTZd3dHALz1I
         p4ToVSVy+zWWVaJU8M6nyR4q5vz67eBPHvTllAiL+i/OamEmo5V798JavNKaHM+V7YFd
         6l8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795644394; x=1796249194;
        h=subject:to:from:cc:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YLae1N0kg2wg3olCT+catsqeX0HY/gzgAbC24mD6VL0=;
        b=RIX+IiNQ/Eml5LLLyE1runugXR/1v8/g/JH6VcWxQxJ1mE6M1iGtSxqBPI1kU0kJVT
         BHAnZ6XgiJRzjBYhylTWJJj/TM+9yAzAYNHby5jsDYGqMHP9EKyuYoOWXYg1iALRJ9kO
         PMyJHYU4M6Rl5ckOOsIb3mccQMM95UtqAV8tBnbzCl8YFEcdJ/kE0kYumC/+WYcrIHdb
         JrLgFnryWWWTd89bEam9gQU84qp4KpvJVmgtFYOV+1VvvCSn8R8pOTp9KLZyfLQK1ec3
         FaVJ0N1N8ASAtetjeKM6BISCc5O9UPFjvBldMJJL0KtQzmG3q3omwJ4f6VgVmFhS10M4
         3FtA==
X-Gm-Message-State: APuU4Z+V3Coi12ivN1cJ43goyOVGPjjxMFgXFT3IHsvrealQbk2QjGtw
	WkcHgqqLd1XZMIRbBjiOxcI+cAIvUQKF7+FNfTNO9rx8LuS5zy/4wH5l8kOVC+4v1pc5mkBoMHh
	lwZGBSDZ24g==
X-Gm-Gg: AZFdTZc3V7d7fVlzJJZuydiHMNmpDO/DG92kdLJ1I7f0lU7oMNSG2mafBOaTKFuHfLI
	LN70Inf1tizLAbxGplDxIkHon0PpPZ0hDCFGwmI+iufmzCRJ3poaTax+lNkfShe+8L+x8t86PSg
	UpO3ItE85vR0lnxwX7jZD5wOGxsl+V0LjLMw6zdcwKRPNu1/zEJeRJkcRT0tPpEeoQrGpeICypM
	Y81wA2wiD5vu2hAXMmikFdld5Vwtt7HmzW0XuhaDe5Z8qwkkY/zlPAGaTtggSE4DsYOeGdAp78n
	PGMzngd5Fxut5X9fYM6Wjxi9DQSv2nHtXEsntW3tM1L9JQfAdkLskEkEVfWBaaZGHmpL5Wf0hTS
	0j/cevB3/qaJFobIvgHgipbG2tVffqKM8zB5zyxv50UiAv/KvOWNYxY1xVfnDnhNFx53al8KnFn
	DxDPArbZm8eYS04FspBslojL+DO2uIOXxG5A/lxD5FWMphqTZWJDnRxj5O7BCanYqhzVDmmNFdw
	290a6npV2kJnQeaCGWxekpxcCoGigqJQYUkYbknHOgeBTfTJRZgYISm6jlSfwXMr6MgqGOnDFv3
	HgQsLszZq5K2Oa629NSZNMBTkbFobe0ThGag1/KV15jJddcWEztPcPiYVtg8UP9kfpkbo4PBoqj
	fPxzgSkpPAViq9PmAhY0nhKkzttD/4IQdIXe9kztuVui7VDxp
X-Received: by 2002:a17:906:9c10:b0:c50:e9b4:3c9f with SMTP id a640c23a62f3a-c513a88bd77mr1186190866b.14.1795644394001;
        Wed, 25 Nov 2026 14:06:34 -0800 (PST)
Received: from localhost ([2a02:21a0:10:748:2::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513acff65bsm721262466b.4.2026.11.25.14.06.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 14:06:32 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 23:06:31 +0100
Message-Id: <DN4MT9L8BQH8.VY2522F55XYK@okonski.org>
Cc: "Peter Zijlstra" <peterz@infradead.org>, "Vincent Guittot"
 <vincent.guittot@linaro.org>, "Josh Don" <joshdon@google.com>
From: =?utf-8?q?Jakub_Oko=C5=84ski?= <jakub@okonski.org>
To: <stable@vger.kernel.org>
Subject: [7.3.y] sched/fair: cgroup::idle preemption fix
X-Mailer: aerc 0.22.0

Hi,

I'd like to see these two mainline commits backported to 7.3.y:

  9a92f776dfa6 ("sched/fair: Use guard in sched_group_set_idle()")
  75545668ae0f ("sched/fair: Make cfs_rq::idle the sum of ancestor tg::idle=
")

The second fixes a regression introduced in 7.3 by 85570f10a4c6
("sched/eevdf: Move to a single runqueue"): with the flat runqueue,
wakeup preemption no longer considers tasks inside a cpu.idle cgroup as
idle, which made non-idle tasks wait instead of preempting them.
The first patch is a pre-requisite.

Report: https://lore.kernel.org/all/58dc8e8a-7260-43ce-aebb-8d9c29a6afc9@ok=
onski.org/
Series: https://lore.kernel.org/all/20261107113639.GK2668200@noisy.programm=
ing.kicks-ass.net/

Regards,
Jakub
