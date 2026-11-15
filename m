Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794713794;
	b=4MUOZuTdbGi5O0fwjU5bE4bjBiQQ34giMFaSLJfx//1aSNd/we8eHgjDup6yPTei07Lr
	 dppDb6rx1JO718G1aF0Wxj4QRh3iPnyBqjbhp5yv9n3dsm43Bbfff8t6WIouQdjppWTaz
	 xMSRE6a+7qeDG6JyHJrsLQ+PEovYcKDaFVQQpdm1SHh5Ol4UoDUvS4hsk9WIGgsmVpOq0
	 klnLmJXo41j6QJOy/Y6gTAHY/Daa/dzUgvurJV9bSR/COc2ZCZrl9pmkd5rhuDcF73KsM
	 rKjbXWiz2mVPkD6irFvlKKXLrzduosViD4zOIzh2lxB6CMTcfzxv6kmcHTN+yzAo7lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794713794;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=bqR0RcC9v5qQRowJ7OkJmMT8g0ibCUrIqL4iY9KFnZA=;
	b=FL8MF9L7e3/adabUoHCIQRV5Kd3K7UXncfN1QYvVaeK/nVs95c/h299LauVZhyM1K2xo
	 oJ9bOeTPVfnXxzrFoc6U+KTO0pvfYlbxSdM2pPbr2/Fcor72jqdIAesbDcb83Lo+V/IP6
	 ccZufSD/L0/vS4yGhyGwnw3JQ1pU/W4+0S81jHt2EpJGN6ofGHT49yVNHryg0AfL3nxvn
	 pMv8SrNOshqYZ/n5ut26xykYHPyRyvL00a1mcFpFEBMaMRAa4sjN1pvszPxy7WxK86150
	 IrJQ0i57plMeqbY8ULmWsyjB4D5JjPTu0UEDrvRoLvLCQR7eeO4Up4gQTP4pnFPT3uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--chriswiseman.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=E3L+3dPb;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD2B606A329
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 03:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CD2B606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chriswiseman.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=E3L+3dPb
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30bcb065bfdso2951119eec.0
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 19:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794713793; x=1795318593; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bqR0RcC9v5qQRowJ7OkJmMT8g0ibCUrIqL4iY9KFnZA=;
        b=E3L+3dPbIJSiv27ubSBF0gyvXUf48aR2N6ImxJxnZsMgcC40Ck2hVFrVZzk6/rKn79
         PikIBfYyJbBQBWXyxuhHGCH/etL8VkZOGeDbpZ+GYorTEiw8wLyVjKVrxAbtqlCoUJIr
         3iEOeXYP5UNqpd8EDxuy+t02Ue0FL054ka2q9YxdPZXVz2a+d7bxIIQGjUFoisu6Is6F
         2FuqIxp5Et+2RKIJCU9KX9jUKLnoD24idOv4zUckRr610e14r3zhN+m9H9z7Ff/GvQyJ
         VJfJc1yH/AwRhL8WO5HwoSZgNERXObaYE83nFqr4nLYWF1Kyyl58etCa26dCtjqTPcXU
         GKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794713793; x=1795318593;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bqR0RcC9v5qQRowJ7OkJmMT8g0ibCUrIqL4iY9KFnZA=;
        b=UCN+S70Euwdj5gSsqdEZfDC8Kbzl6CRf7ZPOwlPydZjKubcXtQjVnesHQsF+kgFb/0
         FW3inD1CXtiRjxGBn6nWeLv2sTLdDnLD4FffKoCyMfIOhLRazFHm131I8athWR3WN9xO
         8x2JmPvJ0/NXAabQ5F8XnntdKyZCVJswkdZKF8XlhZF/odiezQINSEpvDFnc0euKmwlc
         eOk9QjfpRSkdC/af9vGuamq2EElfNE8JcSVkRwx8dZXayYMzfPTAVzGtZIfVoyMnHa50
         Kjyh8HN1K/7Z2YMj4S2Pl6VTjSSWUZ0+1XAnebDDHYvDLvOnR86HpfvmXvk3MFh2Cifo
         arDg==
X-Forwarded-Encrypted: i=1; AL+hErFlP+tcA4MCzsbbJRattJpItZF0+NcAOIhYG44q9xPfJlPPhJgJeH9u/dqCGG6PT4ggdgiNQs4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/HUgRho/YFBhbcpA3uvRwcNt0xQHoRoqY8YrdyYgycdbUYj6af
	PSH5pGnFfSBWQ7z1CcSC3kGeW/tiViefAfKeop5yea2GkO5z5XLzYXvuU8g4UNNY5hhwa4uU5aX
	XEmxyrMEgvbabp+v7uUqSB0GvmElDyA==
X-Received: from dycne10.prod.google.com ([2002:a05:7301:c8a:b0:369:f864:c5e])
 (user=chriswiseman job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:b14:b0:37b:4a2b:81a with SMTP id 5a478bee46e88-37b4a3a4b7emr2845579eec.4.1794713792906;
 Sat, 14 Nov 2026 19:36:32 -0800 (PST)
Date: Sun, 15 Nov 2026 03:36:32 GMT
In-Reply-To: <20261115023115.GA3752240@joelbox>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <18e815d3ba49a353.3137322e32332e3235332e313736.192c60.0000sendgmr@google.com>
 <20261115023115.GA3752240@joelbox>
Message-ID: <18e81aaf93650e1b.3137322e32332e3235332e313736.231b55.0000sendgmr@google.com>
Subject: Re: [PATCH] rcu/nocb: Keep lazy timer intact on second lazy callback
From: Chris Wiseman <chriswiseman@google.com>
To: Joel Fernandes <jfern@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Boqun Feng <boqun@kernel.org>, Josh Triplett <josh@joshtriplett.org>, 
	Tze-nan Wu <Tze-nan.Wu@mediatek.com>, Cheng-jui Wang <cheng-jui.wang@mediatek.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Chris Wiseman <chriswiseman@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi Joel,

> Looks reasonable to me. Is there a test case that you added to find this, or any
> power savings that you found with this added patch?

I spotted this while tracing idle rcuog wakeups with CONFIG_RCU_LAZY=y
and rcu_nocbs=all, where rcuog kept waking up after 1 jiffy whenever a
second CPU in the group queued a lazy callback.  I verified it with
rcutorture (NOCB01) and measured a light background callback workload on
an arm64 system:

                        Before          After           Delta
rcuog wakeups:          1,885           1,174           -37.7%
1-jiffy timer resets:     739               0          -100.0%
SoC power (CPU+DSU):   94.1 mW         76.5 mW          -18.6% (-17.5 mW)

Thanks,
Chris
