Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029B9526ABC
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 12:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790686191; cv=none; b=VQUW5e8D2irLriEge7THQWan+Q73zFCVf5TUW4hDgp9dDFeHSX/43SlJWyn5yMs0bKp2GQu9y6mVoVbcQry/EUBX/IaHAv5qhuwLhKfhh7YTlQHMVIr40/qygCHPy5jRL+lbOMmCI+f2eLQaBxGKkC4K1ZugTTXZt5Qe+r4IKAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790686191; c=relaxed/simple;
	bh=ddPjAgqOAexQn6SiMZ0/vDyDZI//jACyAkgt0yNWJQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IswlmGttA0f5nHhgVg4o3bWtMPckzg5O79+Q0WRHL7jYr3BRpFXlKTYG8CJGhZO7KuRcDywxDaEVOXSMBk4BrZq7NRHLXnroGM8daQlvjTdl3S1XO1jTPj+ibWevJWeUG6vea70lX9gIUZZzIusqQKHPpLmWsBPOU+DINiYKsD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQ/Bqa+d; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQ/Bqa+d"
Received: by mail-oo2-f43.google.com with SMTP id 006d021491bc7-6d811890762so1383111eaf.2
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 05:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790686189; x=1791290989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=biINQt2l096Gb8cXBkH2MIBuz9s+X7G+Hedzf/dVVx0=;
        b=XQ/Bqa+dMsqbiSot+Qri0c5WYlPHDHB8o5zt/TGGZjFDxStpAeVGEIiosygDWUAiV3
         1JMzA3+6ty68L9GVsHcXxoQlA9/LcFrEm/rliq9cfOHMizgfuXaiQrQteOXRR2B7kGtX
         N45niRZvpOIzeDBUuSnilUcOGNwSUKVty669YeN6h4KrJQhcVzFT+Jy0nf2CHIVolzIE
         DABwL32NFM7C9C9FK2Lp28G6W2x2XzG0Cp1TSZxqoZwJRJEAcQ+2TSaQHMennTeBT4zN
         wUZp6lRI00FrEKj8ascz2O5Tsf8l1abe84xq0uJzboowd8OrNnjwtUJWq2S6y2Abn1K/
         uh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790686189; x=1791290989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=biINQt2l096Gb8cXBkH2MIBuz9s+X7G+Hedzf/dVVx0=;
        b=P74MYa0svXsWkKb/mvr4lDvvtWVPyhb8I4aJSC9AOZ7Z5m7reIizaq/+a7ry00CsCz
         Oi/hsS8AoNsD0K7wJK+yP4iNMsONxT5b+trq1tuaZtQCloU+6HVf2qK183OU4gGeXh4O
         DdKYiFv6o8+k+Zo7kUe3cJGfv6QSbgILvkrj6nGawVuwtCACOrRbdbB4GpKYoBfjwRdM
         zj6nRV5WNbgk9IVnM4husEuQo/brky5ccnGf/HSPOG6JQ40npPeoZPyndkz96BHfWmkf
         1NCx98KPRilub3uvcuoLFF1jWiR0kwARlpjgbZaDi+nThzAO7ajesE+59ERqCl5WUFpc
         YESw==
X-Forwarded-Encrypted: i=1; AKwUvBzfm9GM0wJE/KZTFPZeCEVdNQVRz+akvz33SKDDWqMnV2lOAo2DqZzDpgAI5LgSD/579gn4QmI=@vger.kernel.org
X-Gm-Message-State: AFuF++m3vK7uC/vJ+fTpsTLxDs5lAkoHEbu+tj9WLNj+yMFjV1DJTnuN
	HnjfzeE/Wf9rxsIzt8OekhWKm1svVCbeRFWGBqEcVn0u0pzpabdbQ55c
X-Gm-Gg: AYBFou3tsQ4orM8FPAMqnD+ThTNxM9gka9hTw1QwVwRMI+2UHOYAUJ0YX7bK5vmi7wk
	FijPEYRkL6ox7AQreBSpQJQEqfdwh0UDnSyUrR7E1ytPRuJzPnopKb2PLsxmodyKMzdI3WoTkYm
	+Wtp0r7h/BBm+pn+yR05n8Ocw+CVk025x48vY1QY0iph2KbRM1991zETXzn+OpPlTyuBv0HwTTW
	68xvRq6NLaAIreuyHFH4xX+/iK4WneMgNFISztiefXcZJ1CYUGyimApkmj7/B332cdQXhzslWpR
	K0GqYrvQbYzI84ZpesTLVZ0kcAn0z5ckDbqYuLZPw80DbBeOn3mnFdf3IR0ZX9P8/gUPx69jsqJ
	u1YjvX5DObfCYa5+cT9x1kBqy2jMqm7nerptB78EndkW7qQmDTyIcJee9592DqxUIZ1WgeAReKw
	LMLxlI9e1/n9gfNBT7FvaE/XdSDGf6qEB/YmwNrgpfk25PxNrSrv2El+UXdVUNUE5B7hgpzM4Ac
	E70yY76oVi8WmcZjFw5CpSfySWdbYsSyrf46Lwh
X-Received: by 2002:a05:6820:c8e:b0:6b3:50e5:c625 with SMTP id 006d021491bc7-6d43f7a70ffmr11792413eaf.32.1790686188675;
        Tue, 29 Sep 2026 05:49:48 -0700 (PDT)
Received: from archlinux.lan ([136.34.156.120])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d8830ab0d7sm6781572eaf.11.2026.09.29.05.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 05:49:47 -0700 (PDT)
From: Danish Khateeb <danishkhateeb03@gmail.com>
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Calvin Owens <calvin@wbinvd.org>,
	Yibo Tan <lhfff@tju.edu.cn>,
	linux-kernel@vger.kernel.org,
	Danish Khateeb <danishkhateeb03@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/4] pps: generators: stop the generator on unregister
Date: Tue, 29 Sep 2026 07:49:36 -0500
Message-ID: <20260929124937.51114-4-danishkhateeb03@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929124937.51114-1-danishkhateeb03@gmail.com>
References: <20260929124937.51114-1-danishkhateeb03@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both generator drivers stop their timer and then call
pps_gen_unregister_source(): pps_gen_tio_remove() cancels its hrtimer
and disables the TIO, and pps_gen_dummy_exit() deletes its timer. But
/dev/pps-genN and the sysfs "enable" attribute are still there until
the unregister, and a PPS_GEN_SETENABLE or a write to "enable" in
between starts the timer again. Nothing stops it after that: TIO's
hrtimer keeps running in the devm memory freed by the unbind, and the
dummy's timer is left in the unloaded module.

The drivers can't avoid this by unregistering first, as TIO's timer
callback uses pps_gen, which the unregister may free.

Stop the generator in pps_gen_unregister_cdev() instead, under
info_lock after the device and its sysfs files are gone, when nothing
can enable it again. pps_gen_unregister_source() then also does what
its kernel-doc says: "it disables the generator so no pulses are
generated anymore".

Fixes: 86b525bed275 ("drivers pps: add PPS generators support")
Cc: stable@vger.kernel.org
Suggested-by: Rodolfo Giometti <giometti@enneenne.com>
Assisted-by: LLM
Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
---

Notes:
    Tested in the same setup, with patches 1/4 and 2/4 applied. The test
    driver got a periodic hrtimer in its devm memory, like TIO's, and a
    remove() that cancels it and then enables the generator again before
    unregistering, as a PPS_GEN_SETENABLE landing there would. Without this
    patch the timer keeps running after the unbind:
    
      BUG: KASAN: slab-use-after-free in rb_erase+0x174d/0x1a70
       __remove_hrtimer+0x138/0x450
       __hrtimer_run_queues+0x2c5/0x7f0
       hrtimer_interrupt+0x3db/0x910
      ...
      Freed by task 175:
       kfree+0x25a/0x6d0
       release_nodes+0xd1/0x140
       devres_release_all+0x10e/0x1a0
       device_unbind_cleanup+0x71/0x250
       device_release_driver_internal+0x41b/0x570
       unbind_store+0xd9/0x100
    
    With it, unregister calls enable(false), the timer is stopped, and
    there are no reports. Unbinding the test driver while enabled, and
    unloading pps_gen-dummy while its file is open and enabled, are clean
    too.

 drivers/pps/generators/pps_gen.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pps/generators/pps_gen.c b/drivers/pps/generators/pps_gen.c
index d80e28dc31dc..452cc12a96f2 100644
--- a/drivers/pps/generators/pps_gen.c
+++ b/drivers/pps/generators/pps_gen.c
@@ -228,9 +228,18 @@ static void pps_gen_unregister_cdev(struct pps_gen_device *pps_gen)
 	 * An open file keeps pps_gen around, but the driver may free info as
 	 * soon as we return. The sysfs files are gone now, so wait for the
 	 * ioctls using info and make later ones fail.
+	 *
+	 * The driver may have stopped the generator before calling us, but
+	 * userspace could have enabled it again since. Nothing can enable it
+	 * after this point, so stop it here for good.
 	 */
-	scoped_guard(mutex, &pps_gen->info_lock)
+	scoped_guard(mutex, &pps_gen->info_lock) {
+		if (pps_gen->enabled) {
+			pps_gen->info->enable(pps_gen, false);
+			pps_gen->enabled = false;
+		}
 		pps_gen->info = NULL;
+	}
 
 	put_device(&pps_gen->dev);
 }
-- 
2.55.0

