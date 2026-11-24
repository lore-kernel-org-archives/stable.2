Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795530994;
	b=4glgMSrdyFZo3gN/PNmBZ6jVwTPNz19Rf9WowpYkARCZpu7dXJuQpB8zWs/KEDgS2CKh
	 cVaDndYq8yMtbnKzwzsO1TPf/XK+8Id8wOnoZ7F8/OzVEV0I7IzferkR7sGF5J5Wq/r8U
	 csIlDHKwVr4LWpLsT49Zdf2GmlVbTV5oQF3+EKhRamHPzFa8YCLcllSWUDBPgcuFo68RE
	 ExeVZpCjvTRNXTr2aLgotW2UU6x5K+XZuz5oyS3uk7uwBW5++eUnptMFOY0mw+7rzQYWw
	 yLM5X29oOPb7oi9WB8gLGrFbf5pjGmpS4/nW/MW48971G8vH32vbEGRV6N2iVSu1Dtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795530994;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=h2mPSw1B7T+UpRiyzIuukEUJ/+X1wVAS23+YiwuYWu4=;
	b=4U60XWJeWEXZ9iwNLmUXUOolPyuvUtc+YBfND3udtZLBpuil0CRq61af4yCkpxRn4VNN
	 4Yzsc5sYlQuxIJnPBIoEg5ipkdFxxq27U8sK6UU1vhqvF54o0+VYdWZjT2dlKTFib5rTK
	 pfKyVmwYWIjqUG0f33xj+FhMi5q8h0I+tEgJE1FpFol9PnmAot338g+XbL4CbTYAcnFof
	 H2Pt23AP/sq5F8KMRQtVRl260PTJl0EK1pZGkEupXXic7UtBHqaHLwY5TgEwCFzQLR4+6
	 Vps7IbnGJfqKi8zR3+9Rm3HPKKGy4Hbo6ZrO2jEsuPXcIEUEXu+LIpbJCist8UcC/sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NyPCxRle;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A6B606A327
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 14:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71A6B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NyPCxRle
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-341eff9e381so7379617eec.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 06:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795530993; x=1796135793; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h2mPSw1B7T+UpRiyzIuukEUJ/+X1wVAS23+YiwuYWu4=;
        b=NyPCxRle6q/PoOijIEeK9vpuUZtBXjlCHeCU++Rk0tyQSNNTTHr0ljpFBIAjbzWHjR
         3kmnaJ6m/BA9bY5ZPezWB1GRz+SGyR7xEDpbYtcfSoAmxXe9/uro4Sk8UyzueIxP7Mjb
         E5iC0b/u/GUH+iMZx7NE4dDBYEUpo+dPusWRwcLMwUOHcGRYblHTl3n2g94nTQP4Z4aj
         XGnviptnxXt3BBtMW2LBGUDl7FTgNBFOtq3yyqdTGExxUnv9Xkf7IClsN+rRJcY6FZDA
         X2C81nVRpIbgDd2Djdjvb7PSTPnGF7Q2lbSsZ3NhoM9GcZoFOJHjqfjUwvAnqWACcyU7
         lJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795530993; x=1796135793;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h2mPSw1B7T+UpRiyzIuukEUJ/+X1wVAS23+YiwuYWu4=;
        b=UudWtdiVbc7FTBKO/Z3esqKddkuFmFifPJZE3oNwCHzuRmK3kt3N/E3yR8bjB6Q1j5
         6dzOrFNY8i73R7eCZl9sM4yoMnWR2cJWOH/xN3z4j5fx8QeaqLDJVLHXnKO9rNY6VKfz
         4vZkKuUPIYJxSWRzxFF1IN7NGe+43ukKqqUNisaQWRumZF8myPBrS/b/W1zEsEnB8ilY
         WyQRcOWWFlolzf4LzxexNN8pNpmkM5llkiyMWsjZdv029AL2kRr9lqjGYIIOGnz8DhBA
         +J3szjRp1TT0mNDnK1fpGRGkzUX4rwIvLNT0PpM4OggMjz2JSwfkbDVJySlGV0nWyA4U
         uuAA==
X-Forwarded-Encrypted: i=1; AL+hErFKKAULC9eYnaJe3VDclZ9jOCRmWtQX9vsR0x1ocUr7eZ8e1Dwaygct1sWppIFzSyjMWwpxaeY=@vger.kernel.org
X-Gm-Message-State: APuU4Z88HAm5lN3vm+V6prymrU5p3TxgWLbNEiKaCsGe669yX9sHoQtV
	9QZgvg7511pXcLiwor5V/AGMqVw+mRAHrLjP7nC+dE9Bp7BnpCzeWe5CYJli9gWhoe17sxnOovp
	UWvxcagRNMy+o4+NDLw==
X-Received: from dyah11-n2.prod.google.com ([2002:a05:693c:83cb:20b0:386:458d:ba4c])
 (user=penghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:211a:b0:373:5561:8d06 with SMTP id 5a478bee46e88-38570c36e7cmr13603125eec.37.1795530992365;
 Tue, 24 Nov 2026 06:36:32 -0800 (PST)
Date: Tue, 24 Nov 2026 06:36:31 -0800
In-Reply-To: <CAKfTPtDb6CZ8WyN8rdK_-9RNhaFRxaZGOE3+EfbkReqkFCCy2g@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261122015729.2512645-1-penghuang@google.com>
 <cover.1795462673.git.penghuang@google.com> <9b14aecb0ad560a3ce5f7925aaaee6e4f4a1a760.1795462673.git.penghuang@google.com>
 <CAKfTPtDb6CZ8WyN8rdK_-9RNhaFRxaZGOE3+EfbkReqkFCCy2g@mail.gmail.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261124143631.4012300-1-penghuang@google.com>
Subject: Re: [PATCH v2 1/2] sched/fair: Clear residual sums on zero task-group
 avg propagation
From: Peng Huang <penghuang@google.com>
To: Vincent Guittot <vincent.guittot@linaro.org>, Tejun Heo <tj@kernel.org>
Cc: Peng Huang <penghuang@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vincent, Tejun,

On Tue, Nov 24, 2026 at 11:23:03AM +0100, Vincent Guittot wrote:
> When fair tasks are involved, the next decays will clear the *_sum
> anyway so I suggest to skip this patch if it's not needed for
> scx_switched_all() case

Agreed -- let's drop patch 1/2 since it is not needed for
scx_switched_all().

Tejun, patch 2/2 applies cleanly on its own with Vincent's Reviewed-by
if you'd like to pick it up directly; please let me know if you prefer a
standalone v3 instead.

Thanks,
Peng
