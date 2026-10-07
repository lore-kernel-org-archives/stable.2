Received: from sonic.asd.mail.yahoo.com (sonic-euwe9-0017.asd.mail.yahoo.com [34.2.88.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D564AFE17
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.2.88.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791384188; cv=none; b=uqbqspAxTN0Mq8CrXYsxz8cVqqQUo2jf5eclrq6rj+KRFvgrdadoyBYXYr6/WlpGHVCmXWVdcEPlQTpl3cvDrdjr+DDwnqOWWuspxDP6dCZu/M1OexUHRNDPpDdATJl43vUZ/Jx3lLUsmtwoDQdXucxd2dCr8zVe+06iVa0Ip3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791384188; c=relaxed/simple;
	bh=SxIIgw0ydlG0i4+/48viYe5sGJmgGy76UbNEZEdnvUM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type:
	 References; b=a1ClYfOLnS8FDMv6ihHIU7sk+ILkIvKwO5ux3IJ5Qr7OS17ol74WSkw2XDAsw7BCKU554BwSZAF2QuUG8c83ByHex5Hc67ecUX6xCm8sSNjAgV7+sxilgxxL4CHIpBP8/O9BC1DwsZSj4Dgiwn2wNZlc5pnDh02ATbSb20l8hrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.fr; spf=pass smtp.mailfrom=yahoo.fr; dkim=pass (2048-bit key) header.d=yahoo.fr header.i=@yahoo.fr header.b=MYz+BQ3N; arc=none smtp.client-ip=34.2.88.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.fr header.i=@yahoo.fr header.b="MYz+BQ3N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.fr; s=s2048; t=1791384178; bh=P4Gq/l5PMpm7kLvXzCF1M+XYf0wCg8LsIG1lD/qNzLA=; h=Date:From:Subject:To:Cc:References:From:Subject:Reply-To; b=MYz+BQ3NYMzxjyptq9CVxyrS3Hr1iIxbNM52iz+okkQqXRJI//8c13Y/CJGfhNuh5cvpi5RJqiBhlh+9gKx1qy9bOzpiHVhynH52x2VGVCEgnEntzs7CsgrLH2ZId6P2lauKnmB5Mz+ulm5MWJLVTkxtR/lDr+FwnefrolziIHr/TQ1ioLBUHFkUSO09x+7yXUvcdFH0/GwdBLBTz9CmpfgV6iEdZmXNb3MJkYCn3Y5KjspUZLHD89x+pSY7k7huEifTaPBfMPE8DIQ0M9zLfFRw14TVn6o9ZWB5/aZT5kcik4nLTUZz48zImdCspZNCvzV8X8NrT7UKqYCuyrF/VA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1791384178; bh=B3mBrPsL0PtpX+nxS6w/jFLPzXARIeFpajclZ5A80x2=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=JdweuBsooOMLDC3ThEbTuq1IsOBEk0JrH/sFFdyUxaLDKMlQZklDE9bmhSNHHZiHeUk7WJg4orZ3rCznz6IiHkVtCd0F2ctoPl85uXSK63fdODrUVdk6hWYGotbXcifezWvZlkPXaLSrkkzAgWiEhUQ1LT4G0UpgN4XpCx/VgBwFPQjhVhl0oV05hfbwnkMv9J9fU5DK8yTVmTk/r0WiJEtIK6elQMdoKTQrsbIlP1RMoSQLFjbAvBkN83u6Op9BxwbF48zIIXfHP/C76S5MhYXJWcooSdD9GJn9fJEFpnLzp6Qy1UEgoCm0G06GspGc+53iByZrhgZEQL0nfb/m4g==
X-YMail-OSG: nJVZRk0VM1mHJLR.iWzkrdZ9U235AYbPZXzOGyAvr5zU72F63lw5uFlrGQ3kNz0
 r4RlaZG4sHMUwoJGnFJjrgHvWkMcG6cdj7vSQfDfICReVRtiU1EXZrTYhDjsKc8yMn74wSxAZ7gF
 nmfP0UR8uAYZtdCSHkW469NTiaEO96Po0Dmd.NhZAmf.spVj7snLpMxqvcHpzQ2y3zqHCx_ac9de
 Gqkki19Rg7GMH6v3.SflVQNM8uqEouQ6IKsGw2K1oh57SufXNhuv69p_j3X9noesQvFmqc53ntGN
 epgSA1zQX_9Pkj9AL394naf3MMSuuGX3AEObnYuYiB6xhRT5agLuBay0Xi26yvF36f6WDs9jOwNY
 MADHfOJq0z5VQAGKZrk4eIM68fwoKKKc_elRNFoacNu7v8AY60mlSeyXJ9uByBc1QzhrAEE96KNp
 rA7iHbg2aRrEE78rvvwPAVU2Wwd0GU6kwxqJcsfp.SGgMLEJPeXJx2mNpgNVsA.3CwpLUm5Elcns
 cFX671jH.Bi0a6YIgoYJj7ANWIoOmTgvWyUTF6jNNpgX4YkCgH9Eiakb_465.3FXp3vvEgAcaKSy
 ZdNzfCMsRqX0UZ4M3c6StEoYejUzVlonBgHzAhn_r8j_k.0iIMIi1KkHIW9fC04ixi1yhDKxhgOS
 D8r8nn_LK_WT91zdLuRK0yuwVhO3ymS8JoLfaHkH33P1bPhFJHnX3Ngh7aTWbTxQDMD8s7BRlR_w
 7tFic6F0LbK3ZN7TMvrQU55LSmoqSgfOjcjv8bxV4DpjEEyRvTaSFVg99NI9jvJoUQAbsbt92mVc
 jTAnQjg8WyijxGz2caMqYK_H8z3gCYuYgenwxsY9C9NhWFjdSDb.oUQn93C6amStVKp3_QtMvkiG
 T0Azq.GNvYUhJ61TVHGX7Hr2x.UyFk3nDFbtR2oTmVbzJxRmi7FnUNRUQBLCDjvoh2D26zNjXcs9
 TNQ2nvg3NeoCZKJaiIidQPRvAryr5mc8QuL0YIzzWqiz52f0TW4KmdpjUqoFgZEskps47F5yH8w7
 tm.V0G8DPqXShjgfF.3leovnJimILUBVdndF1wzhnLXOjoWsFRmYhMuCeUehwcWNQy6rD7uDDmZt
 fNseDjUZWBE1wIKdj886ah4mkQyZSw284.t55jtRcRrqESZBUnzlBuW4ZzSzL8VBUZfpwDJCEOkv
 YgVMU.CaVyawem8ZgDNv_no6XuJoHD5bcDpmOhDiluqOjOJM.86v.7wJE3bD_N9LbJfUyFZ7XktQ
 UxPDZFeLhE.jPsl30neQGV9Kn5FTYxAnIU_.QWmVo3mXun24gqzmW1KQcoyTRXey1BN9mgrN23pt
 d06wb.nFkuoZ3mp5Q8X3UsA3MivdeUyDf_ZfodGnuGux04VEgwNIRPNc5_FGNBOrnQzkxU2Xb3Kx
 pAf.o8uz6l6ZHadznZmfl8yy1ohxt3LHVZffqk83zJd_eswcmi1I9Y64BTMzPBj0YBd.TESCGkAx
 ExAJB2o7pD2iih24BvjOEjL2tr_Ozy1iMFudHoqVKTvHBDDqbQfFjxmlNUYySl5TaPhIkL5gK8et
 DUAC4M3xTfmY2lXKTZ8l8Jx1G6saX_gPrp.FNSZZf016cNtUiO4OROfwm0b7g_1Cg0uiWbIPMEAk
 wyoueSFJ3Gxlz6_LMf0sEzHyZv5CbJDGw48VwKt83F0Nk5nhGkYXxBImATskYHfa0SYFxLh_NyK4
 lqVK99Qphn5k8FYqyUGm8cgK4ueAeq8TbkEak_kzpN_XBH9byqWCJHe1CpyPBgk6TeYORW9z5j8j
 aTiVeAEZ.XqPQtuqy_tPTtpuM9EzHxFaq1KzepXulidKSfPiuGn5AC_CtlkJ_xz0c64P0zCL.45L
 MENObelVqPg3YSN_a3BAaO1CwR9JQgybEAt5hBKUJ8VS7yDueXrZuX6N9U9qOGgfGQE.Ig6EI2cO
 9Qbx7IBxZcytZNClF.rrLklQK4PD6KBR.uHOORdIwsgrtRjRbD74hZJ2aGjZ3LsA6s4zfnXKhjGl
 uKXuR
X-Sonic-MF: <vincentcazard@yahoo.fr>
X-Sonic-ID: 05e14f36-2498-4aca-a18a-02d59f6f8f9c
Received: from sonic.gate.mail.ne1.yahoo.com by mail-asdoutdeli-p-cin-euwe9-prod-sonicconsumer-svc-102 with HTTP; Wed, 7 Oct 2026 14:42:58 +0000
Received: from dip111.lsn.ir2.yahoo.com ([87.248.99.120])
          by hello (SMTP) with SMTP ID 595b8e4b9664dbc7ee9cd2133ad7bb1c;
          Wed, 07 Oct 2026 14:42:53 +0000 (UTC)
Message-ID: <c0f8246b-5062-4499-955f-374bf6ba91c0@yahoo.fr>
Date: Wed, 7 Oct 2026 16:42:51 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vincent CAZARD <vincentcazard@yahoo.fr>
Subject: [PATCH] media: em28xx: don't unlink a dual-TS dev_next that was never
 listed
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, stable@vger.kernel.org,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 Hans Verkuil <hverkuil+cisco@kernel.org>,
 Jiangong Han <jiangong.han@windriver.com>
Content-Language: fr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <c0f8246b-5062-4499-955f-374bf6ba91c0.ref@yahoo.fr>
X-Mailer: WebService/1.1.26668 mail.core.serving.mcws.prd.acl:role.token.mcws.jsmtp.yahoo

Commit 826915b6b65e ("media: em28xx: fix use-after-free of
dev_next->devlist on disconnect") made em28xx_close_extension()
unconditionally unlink dev->dev_next from em28xx_devlist.

However, on regular dual-TS boards dev->dev_next is never added to that
list: em28xx_duplicate_dev() creates it with kmemdup() at probe time,
before the primary device is linked, and em28xx_init_extension() only
calls list_add_tail() for the primary device. dev_next->devlist is
therefore a copy of an unlinked, zeroed list_head, and the new
list_del() hits a NULL ->next.

With CONFIG_DEBUG_LIST this triggers a BUG on every USB disconnect of
such a board, e.g. a Hauppauge WinTV-dualHD (2040:8265), and with
panic_on_oops=1 the whole machine reboots:

  list_del corruption, ffff88b642e141e8->next is NULL
  kernel BUG at lib/list_debug.c:52!
  Oops: invalid opcode: 0000 [#1] PREEMPT SMP PTI
  Workqueue: usb_hub_wq hub_event [usbcore]
  RIP: 0010:__list_del_entry_valid_or_report.cold+0xf/0x6f
  Call Trace:
   em28xx_close_extension+0x74/0x130 [em28xx]
   em28xx_usb_disconnect.cold+0x71/0xbc [em28xx]
   usb_unbind_interface+0x93/0x290 [usbcore]
   device_release_driver_internal+0x19c/0x200
   bus_remove_device+0xe9/0x1b0
   device_del+0x161/0x3e0
   usb_disable_device+0xd4/0x1f0 [usbcore]
   usb_disconnect+0xe2/0x300 [usbcore]
   hub_event+0xe30/0x1980 [usbcore]

Initialise dev_next->devlist in em28xx_duplicate_dev() so it is a valid
empty list head, and only unlink it in em28xx_close_extension() when it
was actually added to em28xx_devlist. This keeps the use-after-free fix
for configurations where dev_next does get listed.

Fixes: 826915b6b65e ("media: em28xx: fix use-after-free of dev_next->devlist on disconnect")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Vincent CAZARD <vincentcazard@yahoo.fr>
---
The offending commit has been backported to stable; this was hit on
Debian's 6.12.111 (linux-image-6.12.111+deb13-amd64), which reboots on
every disconnect of the board above (here the board is attached over
USB/IP, so a disconnect happens whenever the remote side is re-bound).

Tested on 6.12.111 with an equivalent change built out of tree: two
forced disconnects/reconnects of the WinTV-dualHD, both tuners come back,
no list_del splat and no reboot. The tested variant additionally checked
dev_next->devlist.next for NULL before list_empty(); that check is
redundant once em28xx_duplicate_dev() initialises the list head, so it is
dropped here. Not yet tested on mainline.

AI assistance details (per Documentation/process/generated-content.rst):
the assistant was Claude (Anthropic) running in the Hermes agent with
shell access to the affected machine. It was asked to find why the node
rebooted when the tuner was used; it read the pstore oops, compared the
Debian 6.12.111 em28xx sources with mainline, identified 826915b6b65e,
wrote the patch and this changelog, built the out-of-tree module and ran
the disconnect test. All of the patch and changelog text is
AI-generated.

 drivers/media/usb/em28xx/em28xx-cards.c | 1 +
 drivers/media/usb/em28xx/em28xx-core.c  | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/em28xx/em28xx-cards.c b/drivers/media/usb/em28xx/em28xx-cards.c
index b7c534f..5f0f862 100644
--- a/drivers/media/usb/em28xx/em28xx-cards.c
+++ b/drivers/media/usb/em28xx/em28xx-cards.c
@@ -3985,6 +3985,7 @@ static int em28xx_duplicate_dev(struct em28xx *dev)
 	} while (test_and_set_bit(nr, em28xx_devused));
 	sec_dev->devno = nr;
 	snprintf(sec_dev->name, 28, "em28xx #%d", nr);
+	INIT_LIST_HEAD(&sec_dev->devlist);
 	sec_dev->dev_next = NULL;
 	dev->dev_next = sec_dev;
 	return 0;
diff --git a/drivers/media/usb/em28xx/em28xx-core.c b/drivers/media/usb/em28xx/em28xx-core.c
index 0b998e7..5eb1705 100644
--- a/drivers/media/usb/em28xx/em28xx-core.c
+++ b/drivers/media/usb/em28xx/em28xx-core.c
@@ -1265,8 +1265,8 @@ void em28xx_close_extension(struct em28xx *dev)
 			ops->fini(dev);
 		}
 	}
-	if (dev->dev_next)
-		list_del(&dev->dev_next->devlist);
+	if (dev->dev_next && !list_empty(&dev->dev_next->devlist))
+		list_del_init(&dev->dev_next->devlist);
 	list_del(&dev->devlist);
 	mutex_unlock(&em28xx_devlist_mutex);
 }
-- 
2.39.5
