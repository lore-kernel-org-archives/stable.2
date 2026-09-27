Received: from fraori-sdnproxy-3.icoremail.net (fraori-sdnproxy-3.icoremail.net [132.226.202.154])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554093BB9E0;
	Sun, 27 Sep 2026 10:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=132.226.202.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790506255; cv=none; b=NnvLgTaSGI2j9F4kInaGDI6CP3+DfFvisvhpzbRlDlJoLAFRpKfDd654r6cfp5PWaPRawudl4TJ6YqinsZ0PCULDTeCSjJroOMgmhewT5V7BJfaOiAfpp4DD4el7B7uUeTDsOXdN767tDUFzH/Qu9Da66M1roiShys06iU0IJZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790506255; c=relaxed/simple;
	bh=iWLCfLbLIxHuv45meAHo/xi3qtZ0wP1FFo7QenZEA5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gKUFq/pXgW/87Ho8+hJcoVWLxs2UuB1D2Ays/xKhuMsjAiTA8s2v05HIdtssLyNRQdwNi6yHbKSPu8Zx7M5vv244fTYmHTESteUehwEkUOhvNxjrU1XTLuGO/W+jlqYrY9UyoYQOtBSoBqxxfvyHCgo+r/cXl5uVjM7nylOay1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=132.226.202.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wDXkj379Lhq6SU+AQ--.15118S3;
	Sun, 27 Sep 2026 18:50:36 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with UTF8SMTPA id zC_KCgCX73369LhqrEgOAA--.13886S2;
	Sun, 27 Sep 2026 18:50:35 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org,
	horms@kernel.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	songl@zju.edu.cn,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: Re: [PATCH net v4] net: mana: fix reset work race with device removal
Date: Sun, 27 Sep 2026 10:49:36 +0000
Message-Id: <20260927104936.591943-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <179040843066.2160803.16315462315045553577@kernel.org>
References: <179040843066.2160803.16315462315045553577@kernel.org>, <20260922070728.309280-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgCX73369LhqrEgOAA--.13886S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?x1XwOQXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnVvLbuoOKy0xUR2OEh/LyhmHu8jwPU43EZT1yT5+i7Ol8YZ4tL72MHF7ysVS/AkK9lJE
	ZngPvfJyrlRgTqgqo3mp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxJr4UGrWrJw1UZr4kGw1xZwc_yoW8XrWUpF
	Z0k3yYkr1kGryIy347ur1xJFyF93yvyan8JryrWrs5trs8Gr1xtry3KrWYganrCrZa9FsI
	yw40q3WrWas7ZFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8ructUUUUU==

Thanks for the review. All three new findings are legitimate; v5
(following as a separate thread) addresses them:

- [Medium] mana_gf_stats_work_handler(): agreed. When
  mana_rdma_probe() outlives the 2s stats period, the gate dropped the
  reset request with no latch and no re-arm, so a probe that then
  succeeded never recovered the stats work. v5 takes the re-arm
  option: the gated branch re-arms the delayed work, retrying once
  the probe completes; a failing probe still cancels it in the
  mana_remove() unwind. The latch alternative would roll back a
  healthy probe on a single transient timeout, so I left it out.

- [Low] system_wq: agreed, and the work also escaped
  flush_scheduled_work(), since system_wq is a separate compatibility
  queue. v5 returns to schedule_work(), the pre-patch
  system_percpu_wq placement. Whether a long queue suits the 10s+
  service cycles better can be a follow-up of its own.

- [Low] service_quiesce comment: agreed. It now states that only the
  rollback path can have admitted a cycle, because it runs
  mana_service_probe_complete() before jumping there.

On the [High]: the PM suspend/resume path is outside this series'
remove/free closure, and applying quiesce there directly would close
admission one-way across suspend/resume and would deadlock a service
cycle that is itself calling mana_gd_suspend(). A reversible wait
plus a resume-side reopen is needed, which will follow as a separate
patch.

pw-bot: cr

