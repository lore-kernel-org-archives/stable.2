Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594708;
	b=hcCzNlU4RlG+umdSiGgUMOHo60R2LwAKgnt8v6YymeudY1tp5E1enobK/+c3Clm5q49x
	 KP9APQnISqNeoQUfVzPqS5u6zUgt5Syp8mC6ld+zEfGMSzXk61Cz7Nn0xXkrwxGhpZUIz
	 bjQEaqkmZozPBCkkIxFslRXIfZvCr2ZMMLyIIyxUnymk5ZnQwHiwWlcO/tJ4zJmyo2X3x
	 k5hkd8p0IUpKpFoORsYn1ZYiRUKAb7VRAMPnWZGP7lwdOn+4xDK4bD66W0HwyngL7ZE1S
	 tHYxgIAmmQl36kCXPNaw2Bs5uzziGi35qpEYmr6vepIuy7pnP0wLZA4ZZoZFNsglfpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594708;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=6QmC8vorvLwJYtE6+Q2xmdT3OYo3ht5KIlfcBfVgKIA=;
	b=H4r8l75BVyTu5spYfvD4fGLZWMli6bXdQBlwBzUgCpBZ/MV/rctrAYmXr3EyOieUvDUh
	 1wTAtBINhMvODD5is1B6qul64QCMO7q/i3SXi2+G8WZ7JUi5x8RhhRJE6Z4t7M0FYnUQ1
	 LFkrvhRHHglroCcdkyT9QOfhH1CNxeYkyvquTlhBix8ShIOppVluzi3IplbvKQVeELz3V
	 X6cTKtFPu7+yZDe6+G/5KP3tSM2wt892vvHzO/BFuczSuATOolKYxbxTRaX2ImsyBjWf2
	 OaLRdxlzKiwmbiMpzqnTMqpCpRUU9eHtLIskB5BP8NzQCIwJzpYs6H4+K78W43j2Duw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kGBcjhXs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id D0E27606A330;
	Fri, 13 Nov 2026 18:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kGBcjhXs
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E031D1F000C7;
	Fri, 13 Nov 2026 18:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794594708;
	bh=6QmC8vorvLwJYtE6+Q2xmdT3OYo3ht5KIlfcBfVgKIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kGBcjhXs4PtnKLBL8BviXA0cr6/6Z0ecWZC4emCg1JuF56vS2fryeSbjtjRU1L8Ca
	 949Vn4eXBCIRdyrWZL2bfyhcWGk2AS/HF51EDy6zTC6yitVVSEeuCv15o2XAj9qgRG
	 LfOjRo4GErTL0xUThlWFAsI/ZYU6f5pf89PB2VAJ9SbmhbpkbqrceLFGsyMa0z9pT2
	 mfhPDpdOg70S3VYRGhY3b6wLF2zv6AhQSBBqEEqx5NopgWP2NI5ZClf921dNTlOXqs
	 Du84AXZfY9DXTJH77Amg5M3jq74Sp6WRBxQ4nT/+c2JwfOJ4tXUlNPYyhn8JGM48Fl
	 tI5sZPyJ/rrHQ==
Date: Fri, 13 Nov 2026 20:31:44 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Stuart Yoder <stuart.yoder@arm.com>, apais@microsoft.com,
	rlmenge@gmail.com, hargar@linux.microsoft.com,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1 1/1] tpm: tpm_crb_ffa: Only register driver when ACPI
 TPM2 uses FF-A
Message-ID: <avdXkLKJwuNv0vZ4@kernel.org>
References: <20261112233807.70664-1-sidchintamaneni@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="AD514XYzylQTXZCK"
Content-Disposition: inline
In-Reply-To: <20261112233807.70664-1-sidchintamaneni@gmail.com>


--AD514XYzylQTXZCK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 12, 2026 at 11:38:07PM +0000, Siddharth Chintamaneni wrote:
> Prior to commit 677042afb97a ("tpm: tpm_crb_ffa: revert defered_probed
> when tpm_crb_ffa is built-in"), built-in tpm_crb_ffa only registered
> tpm_crb_ffa_driver from tpm_crb_ffa_init() after crb_acpi_probe()
> confirmed start_method == ACPI_TPM2_CRB_WITH_ARM_FFA. After that
> commit, tpm_crb_ffa unconditionally registers on the FF-A bus at
> device_initcall time (and when loaded as a module) without checking
> the platform's ACPI TPM2 table.
> 
> A platform's firmware may expose a TPM CRB over FF-A Secure Partition
> for UEFI boot services while advertising a non-FF-A start method to
> the OS in the ACPI TPM2 table. When the ACPI TPM2 table designates a
> non-FF-A start method, Linux has no consumer for tpm_crb_ffa and
> should not probe the FF-A TPM service.
> 
> On Microsoft Cobalt 200 systems, the ACPI TPM2 table does not use
> ACPI_TPM2_CRB_WITH_ARM_FFA, yet ffa_init() discovers the FF-A TPM
> partition and tpm_crb_ffa_probe() unconditionally sends
> CRB_FFA_GET_INTERFACE_VERSION via FFA_MSG_SEND_DIRECT_REQ2/REQ SMC.
> That request wedges the calling CPU in Secure World (with Non-Secure
> interrupts and GICv3 pseudo-NMIs masked), hanging boot with an RCU CPU
> stall:
> 
>   [    5.507519] ARM FF-A: Driver version 1.2
>   [    5.507519] ARM FF-A: Firmware version 1.2 found
>   [    5.507551] ARM FF-A: Notification setup failed -61, not enabled
>   [    7.150580] Freeing initrd memory: 293640K
>   [   65.515248] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>   [   65.521346] rcu:     10-...0: (3 GPs behind) idle=dd9c/1/0x4000000000000000 softirq=37/37 fqs=5262
>   [   65.530031] rcu:              hardirqs   softirqs   csw/system
>   [   65.535589] rcu:      number:        0          0            0
>   [   65.541146] rcu:     cputime:        0          0            0   ==> 30028(ms)
>   [   65.548102] rcu:     (detected by 66, t=15010 jiffies, g=-951, q=1384 ncpus=132)
>   [   65.555228] Sending NMI from CPU 66 to CPUs 10:
>   [   75.560686] After 10 seconds, these CPUS still haven't responded to the NMI: 10
> 
> Check the ACPI TPM2 table in tpm_crb_ffa_driver_init() and return
> -ENODEV before calling ffa_register() unless the table is present and
> specifies ACPI_TPM2_CRB_WITH_ARM_FFA, matching the check_acpi_tpm2()
> pattern in tpm_tis.c. This ensures Linux only issues FF-A TPM requests
>
> when ACPI advertises the FF-A start method (for both built-in and
> modular builds), while preserving normal FF-A bus probing on platforms
> that use CRB over FF-A.
> 
> Fixes: 677042afb97a ("tpm: tpm_crb_ffa: revert defered_probed when tpm_crb_ffa is built-in")
> Fixes: eb93f0734ef1 ("tpm_crb: ffa_tpm: Implement driver compliant to CRB over FF-A")

Pick the older.

I attached a prepending patch that caches the start method, which can be
later used in tpm_tis and tpm_crb.

So that totals four patches:

1. My patch.
2. Your fix using the cached value.
3. tpm_tis update to use the cached value.
4. tpm_crb update to use the cached value.

Fast-forward when these are in the mainline, I can send my change with
Stable-dep-of tag to stable@vger.kernel.org.

Br, Jarkko

--AD514XYzylQTXZCK
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-tpm-Cache-TPM2-start-method.patch"

From fc841edc9b4036bed36126dbdc7fdd41cee185c8 Mon Sep 17 00:00:00 2001
From: Jarkko Sakkinen <jarkko@kernel.org>
Date: Fri, 13 Nov 2026 20:18:42 +0200
Subject: [PATCH] tpm: Cache TPM2 start method

Both tpm_tis and tpm_crb have duplicate code for retrieving the start
method from TPM2 ACPI table. Eagerly cache the start method already at chip
creation. The cached chip->start_method can then be used by the leaf
drivers; or ignored depending on the requirements.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm-chip.c | 36 +++++++++++++++++++++++++++++-------
 include/linux/tpm.h         |  1 +
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 0be5dbfaa72e..540dd366effc 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -256,18 +256,24 @@ int tpm_class_shutdown(struct device *dev)
 }
 
 /**
- * tpm_chip_alloc() - allocate a new struct tpm_chip instance
- * @pdev: device to which the chip is associated
- *        At this point pdev mst be initialized, but does not have to
- *        be registered
- * @ops: struct tpm_class_ops instance
+ * tpm_chip_alloc() - Allocate a new struct tpm_chip instance
+ * @pdev:	device to which the chip is associated At this point pdev mst be
+ *		initialized, but does not have to be registered
+ * @ops:	struct tpm_class_ops for the chip.
+ *
+ * Allocates a new struct tpm_chip instance, and assigns a free device number
+ * for it. Must be paired with put_device(&chip->dev).
  *
- * Allocates a new struct tpm_chip instance and assigns a free
- * device number for it. Must be paired with put_device(&chip->dev).
+ * When ACPI is enabled, additionally tries to eagerly cache the start method
+ * from TPM2 ACPI table for the devices that need know it.
  */
 struct tpm_chip *tpm_chip_alloc(struct device *pdev,
 				const struct tpm_class_ops *ops)
 {
+#ifdef CONFIG_ACPI
+	struct acpi_table_tpm2 *tbl;
+	acpi_status status;
+#endif
 	struct tpm_chip *chip;
 	int rc;
 
@@ -275,6 +281,22 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
 	if (chip == NULL)
 		return ERR_PTR(-ENOMEM);
 
+#ifdef CONFIG_ACPI
+	chip->start_method = ACPI_TPM2_NOT_ALLOWED;
+	if (!acpi_disabled) {
+		status = acpi_get_table(ACPI_SIG_TPM2, 1, (struct acpi_table_header **)&tbl);
+		if (!ACPI_FAILURE(status) || tbl->header.length >= sizeof(*tbl)) {
+			chip->start_method = tbl->start_method;
+			dev_info(pdev, "TPM2 ACPI table is available");
+		} else {
+			dev_info(pdev, "TPM2 ACPI table is not available");
+		}
+
+		if (!ACPI_FAILURE(status))
+			acpi_put_table((struct acpi_table_header *)tbl);
+	}
+#endif
+
 	mutex_init(&chip->tpm_mutex);
 	init_rwsem(&chip->ops_sem);
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 0db277af45c3..f6cc91615469 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -149,6 +149,7 @@ struct tpm_chip {
 	struct tpm_bank_info allocated_banks[TPM2_MAX_PCR_BANKS];
 #ifdef CONFIG_ACPI
 	acpi_handle acpi_dev_handle;
+	u32 start_method;
 	char ppi_version[TPM_PPI_VERSION_LEN + 1];
 #endif /* CONFIG_ACPI */
 
-- 
2.47.3


--AD514XYzylQTXZCK--
