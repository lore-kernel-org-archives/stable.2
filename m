Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551D73A7F46;
	Sat, 11 Jul 2026 10:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783765265; cv=none; b=lJcZZObbMi629qIGOMH/ec6H4pFu6NFtjx/NYgL+yGMi8WdSt+zCasf1z6BQLJHrbJZWvsQXGBoSROzew8NZrt99vkZVgIYrqWAbxONVr+ivGJHwcZPXNVINB4TOK6d7Hc5mBsqTERd/myvnW4JeueYcDbIOfJb2/M2MhjO9IaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783765265; c=relaxed/simple;
	bh=Pdk7n/gv7WDV585arv1it15NuGPfrFYTgb3IqLH/wTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PAtLfSw+1BMLXJyh0XOo074nkunjXVZUXHO5pAqZTkv1kopkQtissFVKvM+pOKHPGUIwaJjgguFHzI2C18spDHhyesxZNf+kB/08KuiT1Ln3uSaQPy1lePnNrQjCaYWg5kACxfZyw5cS0zdGTiUBeTXMStuqSWOAxClkIZy+SSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hoC3bElT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hoC3bElT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E54C1F00A3A;
	Sat, 11 Jul 2026 10:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783765262;
	bh=m3U/HkqQwesTEFsGEFZ2atwD5gY93zb0ftBz8NMWsNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hoC3bElTfY068wmk8sASR2sgcuSR1b6b2AaK2hZDeaHlTqHU2UKGkZUv3R6IJbQGe
	 vZMfOxK4JfrIPrpNsuxnZdBXG8YXu74NCnkbMUyT5l+CWpYRS1lMaOB3+qSCbs6C90
	 pp7EQETdwneD4vCFKoiMKNJl8c8t+nnYEqmMYRbrTSWo0zm70yS9//WVjpvWKMGqwl
	 DUY8i1Q9fT4HH1l6vlmMo5x+/hOvuCLN9Pp0ml/Zow9iB2rkz0V8C0DGsHxS9h42JB
	 FgdDYzJWavXmXvwOOI0CEenCfwTG1kDR/5xR+Hqyd3SXMtvyjrklKfAv/30s3Y1aiO
	 bPLhcKNy67F/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: Re: [PATCH 6.1.y] MIPS: smp: report dying CPU to RCU in stop_this_cpu()
Date: Sat, 11 Jul 2026 06:20:57 -0400
Message-ID: <20260711061631.agent5-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260710225147.24574-1-jelonek.jonas@gmail.com>
References: <20260710225147.24574-1-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 9f3f3bdc6d9dac1a5a8262ee7ad0f2ff1527a7e7 upstream.
>
> smp_send_stop() parks all secondary CPUs in stop_this_cpu(). The function
> marks the CPU offline for the scheduler via set_cpu_online(false) but
> never informs RCU, so RCU keeps expecting a quiescent state from CPUs
> that are now spinning forever with interrupts disabled.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
