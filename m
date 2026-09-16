Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E697A403146;
	Wed, 16 Sep 2026 09:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789550458; cv=none; b=DnQ6Ws+NOEEkZs+3SV49wKqtY9XGJ4R19Kg4C9plOxc9ykt9beeOBpQ2JAM0E8rWNbSh46ZDjZ35005oWT3M2a7lc7LIYLHVdpDK8SZic8qp4XWo87kiBZnR4OxvECNd1sds3zBAnTbk8VCAKHZgVeV+LicEPMf/Q9tAXUpKG0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789550458; c=relaxed/simple;
	bh=6mZETT6UsOD4Xx/4QCar+7R85GChaxOgykZzd+SsBDY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DgumEGmxkgb/f66CyloI7Vnhl+drRFz671P0txye8p8CaUuZrwXP1AixdayJHkQqLMhE5pjDCxIn32BU0V8C0HyVQP/hmCgIzLgKwFaEDPJ27qxR4UqZfVlW2PgNtNOf0tJctEIrBy1HYem0aDrUXJZeGvJDLXJ2XMkqe5/Lz5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowADX4D5dX6pq2T7gBw--.41632S2;
	Wed, 16 Sep 2026 17:20:29 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: aris@redhat.com
Cc: bp@alien8.de,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mchehab@kernel.org,
	qiuxu.zhuo@intel.com,
	tony.luck@intel.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] EDAC/sb_edac: Fix pci_vtd reference leak in haswell_mci_bind_devs()
Date: Wed, 16 Sep 2026 09:20:01 +0000
Message-Id: <20260916092001.2000245-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADX4D5dX6pq2T7gBw--.41632S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFWkCFWxWF45tF13GF13CFg_yoWDtrb_uw
	1FvFn7XFWkAF4DKwnIqr13Zr97t3W7X3y0gr9F9w1fGFyYvr45XF98GF9xArW7WrWUuFyD
	Kw4jgFWaqr1xujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JULo7
	NUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBggMA2qqPpSPIgAAsG

In haswell_mci_bind_devs(), a reference to the VT-d device is taken
with pci_get_device() and stored in pvt->info.pci_vtd.  If one of the
required devices is missing, the function returns -ENODEV without
putting that reference, and the caller frees the mem_ctl_info along
with its private data, leaking the reference.

Put the device reference before returning on the error path.

Fixes: 50d1bb93672f ("sb_edac: add support for Haswell based systems")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/edac/sb_edac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 7b282dfd093f..5075c703e19e 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -2846,6 +2846,8 @@ static int haswell_mci_bind_devs(struct mem_ctl_info *mci,
 	return 0;
 
 enodev:
+	pci_dev_put(pvt->info.pci_vtd);
+	pvt->info.pci_vtd = NULL;
 	sbridge_printk(KERN_ERR, "Some needed devices are missing\n");
 	return -ENODEV;
 }
-- 
2.34.1

