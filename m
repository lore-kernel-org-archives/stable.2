Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795873112;
	b=oAp7yh/HujG/zE/3bt3AIbytpVGrpaEGYGjH1PF9CyBThrGoQRA0/rXDyDvJJOlGBEsH
	 qPJv+Afc3MnjZtr3n7ReZR4u4EYBHunszt5mcwsXgdMUBBzNekw8HHvbzJ42p97i37jTB
	 zvR5/rnNrAgmmN06E5Xphs4QeW5fldhQ83gIImZZYW5q+lOv5Ov5TzLVSEgLyQo2IHDxL
	 X4eKxbA+otsPpUlW0/+J6SvydcjZKp2f+J2QSGFNIULYv9N5KxEy0j8RoqcseJBsvzyp9
	 REOAtRA0ZTDL/1jwzabAgyoOH9uxhvnxi0dQGkA30+eIqqQD3Jj/k4hSOGYGG9Oc80g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795873112;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=VTacDzAA1ESFTjHp52qh+p5lhJ/YIsbYiH3IBIWoBxM=;
	b=LDfDpHqdDwF8KqZSO0mJyVKrfn5ko9IflERHYtIX8MZVSTAgzhdPYR14a2X7botlVRhx
	 ALX1WCrcrbz1bRNRrJXAksl4Y7y9ZnHe+HoBxyhxjkZGtwebqhaeyCqLyuBtoX5PD1zE+
	 9fPEcXWerSj3gl4/dxFQZDGvRqllecNdxS5TUlaR26ZnPiy0H7XOLs//JckYN/enRAVQz
	 7M34cGwrFyxNH1UlC4+bQD3oRuYZTiLo2swU/ZjK50AWlOC59wQCuLOXIhA2IXzClBKIj
	 A+BcsCSv5SHKVjPz0GO/CsyxNiuXqw6fXxTc5KEOwTztd0GStS/GCdNzM1No+LP+png==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fjfgeuEL;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0788606A31C
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 13:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0788606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fjfgeuEL
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so86727555e9.3
        for <stable@vger.kernel.org>; Sat, 28 Nov 2026 05:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795873110; x=1796477910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VTacDzAA1ESFTjHp52qh+p5lhJ/YIsbYiH3IBIWoBxM=;
        b=fjfgeuELEZMeBDrsrIQzELostqzTXAegTAWekuSYvYMBLf9i+mo09XPI0IqSPzxkmM
         O//X6YH2UuFf58xgWQZsCJ82YjRSrZZzhuSHyhZRpd/YwEpVN9rlhqYhYFMRVk9EpR8D
         UCHdfM9QRBt1aY0eybCUu/BnPkJ75+/i+F/jtaXHECfKxpPVE6KwGlgqZL3OE8kbFcvD
         jzfdf4CU/GYkwyIwE8ALIFqipKBJyqndYJEboXlBqNIlRbaSc8WgXGmUY2nRmHWfFAQs
         5invxAv91Xsu2WUtjAW+towu+NTWWkn5/8z/uQeoOf9qsjkNAM/iG0p7JBu3tf23JsI0
         K5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795873110; x=1796477910;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VTacDzAA1ESFTjHp52qh+p5lhJ/YIsbYiH3IBIWoBxM=;
        b=TC3rIA/690GC9rYGikgOLT/CF552clyyROesXCk3QgHSXVxUD4u5szmp24nV3SCL6Z
         nc8Zgfty1flO4s9pXVdK8lWiODHriackZ5Co43HhS+JHQ9vg1uvQwA9d3k6KkldgY4hT
         0GQIL9x6aH2U7/+dbJpmKXf5r8TTMEDUk58tFB/LaQLwdwYgUiwt+f8KGJW61Tg9C75t
         mSXNkP2xSsVuTAgzQ0sosYNRPGzC5Wo2eJbAqOVzqVMSXb35YBKwB5bQJ59nVKQETHcF
         TXAIRcFlKaLCzEklJH6/6ltfcXw/OGnxenB+Un2/OE6r8TOceJ5sz1CsnErmt7cbpHNo
         guvQ==
X-Forwarded-Encrypted: i=1; AL+hErHYXW8hdPhV24dWmouMgxgZAOJnj7mUuWU7bR85cMc/pN8NdPj+taVKhaGlUpsRDNBwlW5g0xk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9BRIAitrgAPbuh2nwZ17l0BdGq4/0M+hUBOAWKnUz/iTq7CTyZ
	Joh8TyBBnjKbUd9qOWZMBnlx6gsqXhYk97rULvPkFuANMcND6dgNPW6h
X-Gm-Gg: AZFdTZeedRLOkZC5ZGjlqJ0AjI+xq1FjQChby0CLEx6SEPNqhHEnT1PrvTtM3TZKa+0
	kWewtfjJMZlOODoVfxI6izV/Y8APz26d8FrewagV65N5Eh+mDmpfMQUDoW+JDIxRGJooTT85D+l
	k7m7DI2/bOot7RnmRs823bDctHdml6lEsYEn5XBVvgENu1/JF9CTkMR4sAWZgkXWjccO5FviulZ
	3awPLOm0gpPwYR1wR3S3hR+LZMUk4Ax50oNS5cnXNvj4dYIqcsZNyD6xKFWguUJ9K682L1bIxHQ
	pUof4cmF7cIjSVK+EZxpm91jRUD+92IRvUJ8M8Z1GUiQO9DW33gpHtuZgqFciK8FdTh8PY+6pPD
	2M7herusYaFBHII3GMQrpQzRrpp8DugK0VfVntyUcYXYPlS3jeVGk/AF93E5F0igquDp52M5Kl9
	SitDcek9SrErdHBiVVJnE5NmCtN/BzCX/43TVnKaAvmUhYrZrFXt1yzGmlbkfvXgGVxAdjom+u5
	zxNs3P+Y+KVBEcR1lIAmAQLD/RpVmmd2iJSM9G+fOmslL3W3JE4Hucd4v6Y2lhdF+2oBPigRccH
	B52Sg0XajEME+db2R80w0jIsVZF/ocjkg1CmOmuCYb8+lrV7oExMIzh+YZD+fqOvpwwlSh0gxDe
	FNqqSqSrXrbdgQbPWqR3Nl5k3mQ/xFvL7Vb8=
X-Received: by 2002:a05:600c:5307:b0:4a3:d327:6ed with SMTP id 5b1f17b1804b1-4bb888283d8mr558194005e9.17.1795873110119;
        Sat, 28 Nov 2026 05:38:30 -0800 (PST)
Received: from pc.tail250202.ts.net ([87.110.86.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906e4ce6sm491389535e9.4.2026.11.28.05.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 05:38:29 -0800 (PST)
Date: Sat, 28 Nov 2026 15:38:28 +0200
From: Janis Edvarts Lacis <janislacis06@gmail.com>
To: Antonio Quartulli <antonio@mandelbit.com>
Cc: intel-wired-lan@lists.osuosl.org, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kurt Kanzenbach <kurt@linutronix.de>, Joe Damato <joe@dama.to>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v5 4/6] igb: link queues to NAPIs under RTNL after
 runtime resume
Message-ID: <jgtd7s37k4srp7zsqp44yrvc675n5pgo44cvkekhdaetmsqddg@56pjiixzbba4>
References: <20261124235723.1135808-1-antonio@mandelbit.com>
 <20261124235723.1135808-5-antonio@mandelbit.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20261124235723.1135808-5-antonio@mandelbit.com>

On 25 Nov 00:57, Antonio Quartulli wrote:
>__igb_open() links queues to NAPIs with netif_queue_set_napi(), which
>requires RTNL, but RTNL isn't held when resuming from runtime suspend:
>this triggers "RTNL: assertion failed".
>
>Link them in __igb_open() only when RTNL is held, and from the work
>item that sets the real queue counts on runtime resume. The links can't
>be kept across a suspend, because __igb_shutdown() frees the q_vectors.
>A suspend now cancels the work item before freeing them, so it only runs
>after the resume that scheduled it allocated them, and it checks
>__IGB_DOWN under RTNL for a close in the meantime.
>
>Tested with the 82576 emulated by QEMU.
>
>Fixes: b75a1dea500f ("igb: Link queues to NAPI instances")
>Cc: stable@vger.kernel.org # 6.16+
>Closes: https://bugzilla.ipfire.org/show_bug.cgi?id=13562
>Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
>---
>v5: cancel the work item before a suspend (Sashiko)
>v4: no changes
>v3: link the NAPIs from the work item added by the previous patch, and
>in __igb_open() whenever RTNL is held (also on system sleep resume);
>dropped Joe's Reviewed-by, as the patch changed
>v2: no code changes; mention the tested hardware
>
>Note: igc has the same issue: __igc_open() also links queues to NAPIs
>(igc_set_queue_napi()) on the RTNL-less runtime resume path. A fix will
>follow separately once it has been tested on igc hardware.
>
> drivers/net/ethernet/intel/igb/igb_main.c | 22 ++++++++++++++++++++--
> 1 file changed, 20 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
>index 6961646..acd9a33 100644
>--- a/drivers/net/ethernet/intel/igb/igb_main.c
>+++ b/drivers/net/ethernet/intel/igb/igb_main.c
>@@ -4146,8 +4146,19 @@ static int igb_set_real_num_queues(struct igb_adapter *adapter)
> 	return netif_set_real_num_queues(netdev, adapter->num_tx_queues, rxq);
> }
>
>+static void igb_link_queue_napis(struct igb_adapter *adapter)
>+{
>+	int i;
>+
>+	for (i = 0; i < adapter->num_q_vectors; i++)
>+		igb_set_queue_napi(adapter, i, &adapter->q_vector[i]->napi);
>+}
>+
> /* Some settings need RTNL, which isn't held when resuming from runtime
>- * suspend: apply them from here instead, if the device is still up.
>+ * suspend: apply them from here instead, if the device is still up. A
>+ * suspend cancels this work before freeing the q_vectors, so it only runs
>+ * after the resume that scheduled it allocated them; checking __IGB_DOWN
>+ * under RTNL covers a close in the meantime.
>  */
> static void igb_rtnl_resume_task(struct work_struct *work)
> {
>@@ -4160,6 +4171,7 @@ static void igb_rtnl_resume_task(struct work_struct *work)
> 		if (igb_set_real_num_queues(adapter))
> 			netdev_err(adapter->netdev,
> 				   "error setting real queue count\n");
>+		igb_link_queue_napis(adapter);
> 	}
> 	rtnl_unlock();
> }
>@@ -4237,7 +4249,8 @@ static int __igb_open(struct net_device *netdev, bool resuming,
> 	for (i = 0; i < adapter->num_q_vectors; i++) {
> 		napi = &adapter->q_vector[i]->napi;
> 		napi_enable(napi);
>-		igb_set_queue_napi(adapter, i, napi);
>+		if (rtnl_held)
>+			igb_set_queue_napi(adapter, i, napi);
> 	}
>
> 	/* Clear any pending interrupts. */
>@@ -9548,6 +9561,11 @@ static int __igb_shutdown(struct pci_dev *pdev, bool *enable_wake,
> 	u32 wufc = runtime ? E1000_WUFC_LNKC : adapter->wol;
> 	bool wake;
>
>+	/* Don't let a work item queued by an earlier resume run once the
>+	 * q_vectors are freed or reallocated
>+	 */
>+	cancel_work_sync(&adapter->rtnl_resume_task);
>+
> 	rtnl_lock();
> 	netif_device_detach(netdev);
>
>-- 
>2.56.1
>
Reviewed-by: Janis Edvarts Lacis <janislacis06@gmail.com>
