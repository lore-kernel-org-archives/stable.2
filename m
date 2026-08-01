Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFAC26B971;
	Sat,  1 Aug 2026 05:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785561121; cv=none; b=kvZbIjBdsdaFAfIAhtPABMSpsu01ffUsFhCyXiuQVVtf0Q3jdYLUWaYmOIBSUivI13TkIOS+NFxr5xFhnPOs05gI+ZrHOnqYC7nFbJkBe2HsVFup7r2/XEv5jQDB+E8bfkS9q6SIhsJwE+42mA6A/4Nj9rmnOMhPTM1Wpt41Y5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785561121; c=relaxed/simple;
	bh=PGDOcNymwDX5T6Omny+4zsabCXKUSa1MC9cwwtCPWFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hVh9Wss+Ns+gvYfAf0E9hAawp069kNGa+IVT4upKGEMq+lm+htk4bPrT3BXwkguQKcjBIdOGatoxC6zJvsovPjlprIQfqM0rgDHFLKSy3uAcSOALgtwNkrbgHWkhFmBaqXb4+B55jUB4Z3dFh6LFcXDSXHjanjxl7I8L+z/8td0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wCHnnwbgG1qXypWAA--.3134S3;
	Sat, 01 Aug 2026 13:11:55 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app4 (Coremail) with SMTP id zi_KCgAX_DQZgG1q8hjIAg--.52348S4;
	Sat, 01 Aug 2026 13:11:55 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	david@ixit.cz,
	mgreer@animalcreek.com,
	oe-linux-nfc@lists.linux.dev,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH net v3 2/2] nfc: trf7970a: quiesce timeout work before teardown
Date: Sat,  1 Aug 2026 05:10:58 +0000
Message-Id: <20260801051058.354165-3-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260801051058.354165-1-fanwu01@zju.edu.cn>
References: <20260801051058.354165-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgAX_DQZgG1q8hjIAg--.52348S4
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?Ugm4TgXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnXz+g1OQfMo27QHy5TwQyZwIAy17UsmYccfUoaeAh3wBL2gcCEq3jlm1XGvHysDtePvN
	+zrg950ikgaNrRwWKnGp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW7tFyxtF18tr1fAr1DCw15GFX_yoW5JF48pr
	4Fga45CryUuF4jkFnrAF1xta4rAwn7XayUC3y09ayfG395GFyxJryDtFyUZFyDAr95u3W2
	vry3Ar4UuFsYyFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
	JbIYCTnIWIevJa73UjIFyTuYvjxUcUDGUUUUU

The timeout work can be running, blocked on trf->lock, while
trf7970a_remove() runs trf7970a_shutdown() under that lock. shutdown()
completes the active command through trf->cb(), but its non-blocking
cancel cannot stop a handler that is already running. Once remove drops
the lock, the handler may resume and complete the same command a second
time through trf->cb(). By then nfc_digital_unregister_device() may have
freed the struct digital_cmd referenced by trf->cb_arg.

Set ignore_timeout before shutdown completes the command, so the handler
short-circuits when it resumes. Then call cancel_delayed_work_sync()
after nfc_digital_unregister_device() and before nfc_digital_free_device().

Handle TRF7970A_ST_LISTENING_MD in shutdown so RF is switched off for
that state too; otherwise a threaded IRQ can re-arm the work after the
drain.

This patch depends on the preceding patch, which keeps trf->lock valid
until the threaded IRQ is drained.

This issue was found by an in-house static analysis tool.

Fixes: 165063f1dac4 ("NFC: trf7970a: Add driver with ISO/IEC 14443 Type 2 Tag Support")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/nfc/trf7970a.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
index 9c6f8db..42e7c05 100644
--- a/drivers/nfc/trf7970a.c
+++ b/drivers/nfc/trf7970a.c
@@ -2015,6 +2015,8 @@ static void trf7970a_shutdown(struct trf7970a *trf)
 	case TRF7970A_ST_WAIT_FOR_RX_DATA_CONT:
 	case TRF7970A_ST_WAIT_TO_ISSUE_EOF:
 	case TRF7970A_ST_LISTENING:
+	case TRF7970A_ST_LISTENING_MD:
+		trf->ignore_timeout = true;
 		trf7970a_send_err_upstream(trf, -ECANCELED);
 		fallthrough;
 	case TRF7970A_ST_IDLE:
@@ -2210,6 +2212,7 @@ static int trf7970a_probe(struct spi_device *spi)
 err_shutdown:
 	trf7970a_shutdown(trf);
 err_free_ddev:
+	cancel_delayed_work_sync(&trf->timeout_work);
 	nfc_digital_free_device(trf->ddev);
 err_disable_vddio_regulator:
 	regulator_disable(trf->vddio_regulator);
@@ -2229,6 +2232,7 @@ static void trf7970a_remove(struct spi_device *spi)
 	mutex_unlock(&trf->lock);
 
 	nfc_digital_unregister_device(trf->ddev);
+	cancel_delayed_work_sync(&trf->timeout_work);
 	nfc_digital_free_device(trf->ddev);
 
 	regulator_disable(trf->vddio_regulator);
-- 
2.34.1

