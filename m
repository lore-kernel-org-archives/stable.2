Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793347010;
	b=uckcq36SYbrsfvNmocN+At1X2Yzpf8wTYrRnvIeUTjGuF5fIRjv6IF6MGG0N3Yd2RcJ4
	 1bmk72aZY6yLur1k9t216azy8Or78o3MVKDM80xPN1OEEL8AhOCdS4AcEmBfRsDh1wFyu
	 X2uCiWGH22XhtCMWUtAKnyE5c9i+CzI0I15ibHGm3SdMCxpXRxZSZa+rtorhCjApamGQW
	 oxN/cBES+DU9jE6cUPxIzshlk47huhz0ONNkfsh6cjJg49LDOF9e7lR6+BiWSrFD2Wpco
	 IbWM+LXHtcRWw4XQbLEbTGUcdEzZKegJfOKb4dcr7s2DoN0DiDgLJUtMa/Vt18pTpKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793347010;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=JXGYxeNljDfE9v0Wusv0u/tqPJ5oQM2BhPc23kAApSM=;
	b=PRulWehBPOsQ5fJcvRSjOafSz9nbTriBoVOJBthJsXeofqiJc3OVUR6i+ls71zCP/Kiw
	 Jn7QkCcwYukc4bUMQ68wnE2PYxvkdLvylb+AQQCus1QDVIoDMkg/Hymii08jP+UQ1glhL
	 1MipNSXU7+Ydc2EzShuqAARhlZgSVf1XpQztN5AwD6K95dBysE15aS0qac/IErHA2lwcV
	 7lScSSvkqoa3Bw8oNc4wLB3mpOTVlT1Kv3Pdqrun6tVOnRhmw+dAymvDUOoqhelElX9Fl
	 ydZSIvkkie6kCba1ftN/U0DJVHHsmCVcLyN37sAAETAEI55q7LOHxoG0bcUqDAGU/QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HGVYJ9RW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EA8606A31A;
	Fri, 30 Oct 2026 07:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HGVYJ9RW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6C71F000C1;
	Fri, 30 Oct 2026 07:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793347008;
	bh=JXGYxeNljDfE9v0Wusv0u/tqPJ5oQM2BhPc23kAApSM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HGVYJ9RWP9UruJCcvFurWZNMnRDrEKMjcAdZiPfBNpT9ZRBw1ededGO3MpgEisiiX
	 fer/w3TsAjVGGOGMbPdhJYH4jJT7XWHF8UN35EEfRWP01QfdpE6DwX7wZfEcoIView
	 35Bu4pLmlMfMS4V+HcHMn62pxonwic56sVv8CLJjHfEkvokEL5zDrQnUKySyOIBZk0
	 wp9xrDboYv0N5Y0Va3CfgghBf7GC8ZD3YTwFZLm+x+MLV9Lfmg0zR7fgCRAyueDTik
	 TbPl+/wevStzdrzM3nlumCLlrt3Juz83HX817I8u6gBPkafxd+k7RSIUCXqBkoGdTH
	 1848LhV6B7C0g==
Subject: Re: [PATCH] qed: drain slowpath tasklets during teardown
From: netdev-bot+sashiko@kernel.org
To: yaojiale02@163.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, Ariel.Elior@qlogic.com,
 Yuval.Mintz@qlogic.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Fri, 30 Oct 2026 07:56:47 +0000
Message-ID: <179334700771.3134.3043092838285502459@kernel.org>
In-Reply-To: <20261028045535.110688-1-yaojiale02@163.com>
References: <20261028045535.110688-1-yaojiale02@163.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix covers only the normal stop path.
- [Medium] In qed_slowpath_stop() (qed_main.c:1412-1419) the order is
  qed_nic_stop(), which now calls tasklet_kill(), then…

--

qed: drain slowpath tasklets during teardown

This patch replaces tasklet_disable() with tasklet_kill() for the per-hwfn
sp_dpc tasklet in qed_nic_stop(). The intent is that a pending slowpath
tasklet is removed from the queue before qed_slowpath_stop() frees the
interrupt and status block resources.

> diff --git a/drivers/net/ethernet/qlogic/qed/qed_main.c b/drivers/net/ethernet/qlogic/qed/qed_main.c
> index 28a8a2b9d501c..abe8a841b2773 100644
> --- a/drivers/net/ethernet/qlogic/qed/qed_main.c
> +++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
> @@ -833,10 +833,10 @@ static int qed_nic_stop(struct qed_dev *cdev)
>  		struct qed_hwfn *p_hwfn = &cdev->hwfns[i];
>  
>  		if (p_hwfn->b_sp_dpc_enabled) {
> -			tasklet_disable(&p_hwfn->sp_dpc);
> +			tasklet_kill(&p_hwfn->sp_dpc);

[Severity: High]
Only qed_slowpath_stop() reaches qed_nic_stop(). What about the error
unwind in qed_slowpath_start()?

By the time any of its error labels can be taken, the tasklet is set up
and the slowpath IRQ is live:

qed_nic_setup()->qed_resc_setup()->qed_int_setup()->qed_int_sp_dpc_setup()
    tasklet_setup(&p_hwfn->sp_dpc, qed_int_sp_dpc);
    p_hwfn->b_sp_dpc_enabled = true;

qed_hw_init()->qed_hw_init_pf()
    qed_int_igu_enable(p_hwfn, p_ptt, int_mode);
    ...
    rc = qed_sp_pf_start(p_hwfn, p_ptt, p_tunn,

qed_sp_pf_start(), qed_mcp_load_done(), the DCBX mcp cmd,
qed_ll2_alloc_if() or qed_mcp_send_drv_version() can fail after that
point. When one does, qed_slowpath_start() unwinds through:

err3:
	qed_hw_stop(cdev);
err2:
	qed_hw_timers_stop_all(cdev);
	if (IS_PF(cdev))
		qed_slowpath_irq_free(cdev);
	qed_free_stream_mem(cdev);
	qed_disable_msix(cdev);
err1:
	qed_resc_free(cdev);

Nothing on this path calls tasklet_kill(&p_hwfn->sp_dpc).

free_irq() waits for the hardirq handler but not for the tasklet. The
flush in qed_hw_stop() is only a disable/enable, so a pending tasklet
stays pending.

Next, qed_resc_free()->qed_int_free()->qed_int_sp_sb_free() frees the
status block that qed_int_sp_dpc() dereferences:

	dma_free_coherent(&p_hwfn->cdev->pdev->dev,
			  SB_ALIGNED_SIZE(p_hwfn),
			  p_sb->sb_info.sb_virt,
			  p_sb->sb_info.sb_phys);
	kfree(p_sb);

After that, __qede_probe() takes its err1 label and calls
qed_ops->common->remove()->qed_remove()->qed_free_cdev(). That kfree()s
the qed_dev that embeds hwfns[i].sp_dpc.

Suppose the last interrupt scheduled sp_dpc and it hasn't run yet. Can
qed_int_sp_dpc() then run against the freed status blocks? Could a freed
tasklet_struct also be left on the per-CPU tasklet list?

Would it make sense to kill the tasklet in a common teardown helper, for
example after free_irq() in qed_slowpath_irq_free()? That would cover
both the stop path and the qed_slowpath_start() unwind.

>  			p_hwfn->b_sp_dpc_enabled = false;

[Severity: Medium]
Is this ordering safe with respect to the slowpath IRQ? qed_slowpath_stop()
does:

	qed_nic_stop(cdev);

	if (IS_PF(cdev))
		qed_slowpath_irq_free(cdev);

	qed_disable_msix(cdev);

	qed_resc_free(cdev);

This means the handlers that schedule sp_dpc are still registered when
tasklet_kill() returns:

qed_msix_sp_int()
	tasklet_schedule((struct tasklet_struct *)tasklet);

qed_single_int()
		if (unlikely(status & 0x1)) {
			tasklet_schedule(&hwfn->sp_dpc);

In INTA mode, qed_single_int() is registered with IRQF_SHARED and reads
the SISR over MMIO. On a surprise-removed device that read returns
all-ones.

qed_hw_stop() calls qed_slowpath_irq_sync() only once, before
qed_sp_pf_stop() and qed_int_igu_disable_int(). qed_int_igu_disable_int()
only writes IGU_REG_PF_CONFIGURATION and does not wait for in-flight
handlers. No synchronize_irq() follows it.

The old tasklet_disable() left t->count at 1, so a late tasklet_schedule()
could queue the tasklet but it would not run. After tasklet_kill() the
count is 0. An interrupt that arrives between tasklet_kill() and
free_irq() therefore queues an enabled tasklet again. Nothing kills it a
second time after free_irq().

Can qed_int_sp_dpc() then run on another CPU during or after
qed_resc_free()->qed_int_sp_sb_free()? It reads p_sp_sb, sb_virt and
p_sb_attn. It also calls qed_sb_ack(sb_info, IGU_INT_ENABLE, 1) on a PF
that has already been stopped.

Would it close this window to call tasklet_kill() only after the IRQ
source is gone, for example after free_irq() in qed_slowpath_irq_free()?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028045535.110688-1-yaojiale02%40163.com
