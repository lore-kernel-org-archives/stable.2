Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794114417;
	b=3f4dsWeqSkcQyby4T1ev+yrJmNsaYvy5B4yUNiNQmXAst/1qyZ8fRnXbBy3LLIseEmMM
	 qvfJNZ8lFPRozFLjtg6hX+I+2b3IR8GePX2ldlvEPMMWzw9/6l0mpcY+V3FS2ZFRLm088
	 MAhih7QyYI2AtI3+z4kUaOcjVKKLGkQAkfDX5Fbi9TqVk9X2kdt4uRQPM11NupIOvSlll
	 2znqaoaRbfgCmbmpzdB9KRVnuk33QLI7sdM/2lKCbOBih7LQyBKmzlzRRTviaBmyxvjHM
	 9eIuswimnZgPiU3mtyfJtikx8XrTPzA7gYgsq/1n0n06yOaGpwdJCpjr4cJAI3S/6Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794114417;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=fEUO3LKECArytxkpAMPac73CzQtXzt7C3xgXVjZFn+Y=;
	b=og+59ivrGPD3udMDowUI1rUpy2ZXDs1jaJhMswG6k8e3Sz7S0idim4kUAs2rzTWhplvg
	 HrWFfstOsgCsBrFJW5MdKtphbD9F5l3FFx1WC6X9auC/jAplDkyQDS/TwxUTCwewzBRLD
	 jxTCZctE7wJ44lejGckeBPZ00qITZsk7JrkAMVUcUtTDAcSI5u8gSC5qfk6PR0JICdD3P
	 +jB0O/YH2OeSAv3NKt5/9/gkefCMaJjKIw+1UUfFoW8gIOI6RLYLc/Uzbufa82bjYEx17
	 e0DqCZ73OJ7HsgWGeZE7hCsws2fNgLVPdTa+wTiG7Q0QN/rrDoC3qsikNsv2n4AvMeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UycnVGWo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4423606A320;
	Sun,  8 Nov 2026 05:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UycnVGWo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162371F008A1;
	Sun,  8 Nov 2026 05:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794114416;
	bh=fEUO3LKECArytxkpAMPac73CzQtXzt7C3xgXVjZFn+Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UycnVGWo2TY0N4NKVwNpGtoCwnLtIYez+UNB3BVMw3JNcfuAiGMW8XGxgnbx1dmVR
	 xWlXATIU6d8dxzcb+9g+D3q4meTPhz+2XL09HKDf6AYPDYgKZru40dFR5v+cCWY+IR
	 xz60lLq3rps2IKVaO/RPMJKzxn9msWneNaladiCKBWENMBGDKDkNtMB9Kci2k8ZHJG
	 YriUWfjgVJKEcHB4Asb+mt232HLVwaSqv4Bi6peou/cIiF3zpG1MKNLQkBPjWchXbo
	 1fSSiuoqYV7i5U5hDuisb5LBLQE1febonFE2RsmcSDgrzZ1cfknKpJAyIT47dk6td8
	 CUw3aAabHGHXw==
Subject: Re: [PATCH net v3] bnxt_en: Take RTNL before netif_close() when
 aborting FW reset
From: netdev-bot+sashiko@kernel.org
To: bcochrane@google.com
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, sdf@fomichev.me,
 joe@dama.to, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sun, 08 Nov 2026 05:06:55 +0000
Message-ID: <179411441563.994134.1253063049402486704@kernel.org>
In-Reply-To: <20261104045534.79783-1-bcochrane@google.com>
References: <20261104045534.79783-1-bcochrane@google.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Permanent hang while holding RTNL and the netdev instance lock.
- [Medium] The patch defers the bnxt_get_registered_vfs() failure in
  bnxt_fw_reset() to bnxt_fw_reset_task().
- [Medium] The patch turns a synchronous abort into an asynchronous
  request carried only in bp->fw_reset_state.

--

bnxt_en: Take RTNL before netif_close() when aborting FW reset

This patch takes RTNL around bnxt_fw_reset_abort() in bnxt_fw_reset_task()
and sends the POLL_VF ABORT_ERR case through that same path. It also
changes the bnxt_get_registered_vfs() failure path in bnxt_fw_reset(): that
path now sets fw_reset_state to BNXT_FW_RESET_STATE_ABORT and leaves the
netif_close() to bnxt_fw_reset_task().

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 33c4cacc8ffe3..f48e67670ccfb 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -14860,8 +14860,8 @@ void bnxt_fw_reset(struct bnxt *bp)
>  		if (n < 0) {
>  			netdev_err(bp->dev, "Firmware reset aborted, rc = %d\n",
>  				   n);
> -			clear_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
> -			netif_close(bp->dev);
> +			bp->fw_reset_state = BNXT_FW_RESET_STATE_ABORT;
> +			bnxt_queue_fw_reset_work(bp, 0);
>  			goto fw_reset_exit;

[Severity: High]
Can this hang forever, holding rtnl_mutex and the instance lock, when
bnxt_fw_reset() is entered from devlink health recover?

bnxt_fw_recover() runs in devlink netlink process context, not from
bnxt_sp_task(). With BNXT_STATE_FW_NON_FATAL_COND set, the path is:

bnxt_fw_recover()
  __bnxt_fw_recover()
    bnxt_fw_reset()
      bnxt_lock_sp()              /* clears BNXT_STATE_IN_SP_TASK */
      bnxt_get_registered_vfs()   /* returns < 0 */
      bnxt_queue_fw_reset_work(bp, 0)
      bnxt_unlock_sp()            /* set_bit(BNXT_STATE_IN_SP_TASK) */

No sp_task is running, so nothing clears BNXT_STATE_IN_SP_TASK after this.

fw_reset_task then runs on bnxt_pf_wq:

bnxt_fw_reset_task()
  rtnl_lock(); netdev_lock(bp->dev);
  bnxt_fw_reset_abort()
    netif_close()
      bnxt_close()
        bnxt_close_nic()
          __bnxt_close_nic()
            while (bnxt_drv_busy(bp))
                msleep(20);

bnxt_drv_busy() checks BNXT_STATE_IN_SP_TASK, and this loop has no
timeout. For a PF, bnxt_sp_task() goes on the same ordered bnxt_pf_wq, so
it can't run behind the blocked fw_reset_task and clear the bit.

A second devlink health recover can't break the loop either.
bnxt_fw_reset_abort() has already set SEVERITY_FATAL before calling
netif_close(), so bnxt_fw_recover() returns -ENODEV.

Before this patch, the same branch called netif_close() inline. At that
point bnxt_lock_sp() had cleared BNXT_STATE_IN_SP_TASK, so the busy loop
exited.

The commit message says that dropping the lock would let "a concurrent
devlink health recover enter bnxt_fw_reset() and set BNXT_STATE_IN_SP_TASK
through bnxt_unlock_sp(), which the subsequent close would then wait on
forever".

Can the same hang still happen when the devlink health recover caller is
itself the bnxt_fw_reset() call that defers the close?

[Severity: Medium]
Is the deferred abort safe against a concurrent bnxt_close()?

After this change, bnxt_fw_reset() drops the instance lock while the
netdev is still open and BNXT_STATE_IN_FW_RESET is set. The pending abort
is recorded only in bp->fw_reset_state.

bnxt_hwrm_if_change(), called from bnxt_close(), always reads and resets
that state:

bnxt_hwrm_if_change() {
    ...
	fw_reset = (bp->fw_reset_state == BNXT_FW_RESET_STATE_ABORT);
	bp->fw_reset_state = 0;
    ...
}

A user close (ip link set down) can run before fw_reset_task reads
fw_reset_state. For example, work for other PFs may be queued ahead of it
on the single-threaded bnxt_pf_wq. The close path then sets
BNXT_STATE_ABORT_ERR and resets fw_reset_state to 0.

When bnxt_fw_reset_task() runs, it sees BNXT_STATE_IN_FW_RESET set and
fw_reset_state == 0. No case in the switch matches, and there is no
default, so it returns. bnxt_fw_reset_abort() never runs, and
BNXT_STATE_IN_FW_RESET is never cleared.

After that, bnxt_open() -> bnxt_reinit_after_abort() fails with:

	if (test_bit(BNXT_STATE_IN_FW_RESET, &bp->state))
		return -EBUSY;

As a result, the port can't be opened, and later firmware resets and
health checks skip it. The stopped ULP is also never restarted, until the
driver is reloaded.

The other in-progress reset states such as POLL_VF have a similar
exposure. This path, however, used to be fully synchronous.

>  		} else if (n > 0) {

[ ... ]

> @@ -15524,6 +15524,8 @@ static void bnxt_fw_reset_task(struct work_struct *work)
>  	}
>  
>  	switch (bp->fw_reset_state) {
> +	case BNXT_FW_RESET_STATE_ABORT:
> +		goto fw_reset_abort;

[Severity: Medium]
With bnxt_fw_reset() now setting fw_reset_state to
BNXT_FW_RESET_STATE_ABORT before this runs, will bnxt_fw_reset_abort()
report a fatal firmware error for a func_qcfg failure?

bnxt_fw_reset_abort() {
	clear_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
	if (bp->fw_reset_state != BNXT_FW_RESET_STATE_POLL_VF)
		bnxt_dl_health_fw_status_update(bp, false);
    ...
}

The POLL_VF exemption no longer applies on this path. As a result,
bnxt_dl_health_fw_status_update(bp, false) sets SEVERITY_FATAL and
REMEDY_POWER_CYCLE_DEVICE, and moves the devlink fw reporter to
DEVLINK_HEALTH_REPORTER_STATE_ERROR.

This is the same kind of failure as the POLL_VF n < 0 abort in
bnxt_fw_reset_task(): a bnxt_hwrm_func_qcfg() failure before any reset
step has run. That path skips the health update, and so did the old
inline abort in bnxt_fw_reset().

Once severity is SEVERITY_FATAL, bnxt_fw_recover() refuses manual
recovery until a new firmware event resets the severity:

	if (bp->fw_health->severity == SEVERITY_FATAL)
		return -ENODEV;

There is also a secondary effect. bnxt_dl_health_fw_status_update() calls
devlink_health_reporter_state_update(fw_health->fw_reporter, state)
without checking fw_reporter for NULL.

__bnxt_dl_reporter_create() can leave fw_reporter NULL, and
__bnxt_fw_recover() can still reach bnxt_fw_reset() in that case. The
other abort paths already carry this NULL dereference risk, and this
patch adds another way to reach it.

The commit message doesn't mention this behavior change. Was it intended?

>  	case BNXT_FW_RESET_STATE_POLL_VF: {
>  		int n = bnxt_get_registered_vfs(bp);
>  		int tmo;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104045534.79783-1-bcochrane%40google.com
