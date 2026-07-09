Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355E936BCC4;
	Thu,  9 Jul 2026 15:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783609874; cv=none; b=RzRv0ppw74TmxbOCAf0ypowD5GK92J7wtj3vVEtHwBwgStl+CY/pmUgSAjHqAM5uUaw0tRSp1mMuK982FPC6lLMZdMNDEanVFsM7nxx2ozuBnH5zAvXapUsy7unOZazFgi/KdSfFipokKo2VROY27kEfdCk0wAQ5k1sQ3WlYu40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783609874; c=relaxed/simple;
	bh=+1Mqk6HFOX91dWo/g2o1OID8xOAt1QPrkSdFHEIktfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V7KcZPXMlxazv80CKmF4JPL9Ly0bJSLUTtsVDel0kTneG0gIn8vQf1ucRWAS3c8L7rJk6kdnpIeHnUcQfeOM2mVHLjCBQj9MR1dmO70E3ctiAwLgZ0x7pwlALrfdzYf7bibf2x7i+K24sPScJv0FaRBhRr9ojyOhBJEYSd9TM3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wCnoCcGuk9q+r4rAA--.13424S3;
	Thu, 09 Jul 2026 23:11:03 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app3 (Coremail) with SMTP id zS_KCgA3cXQFuk9qcukBAw--.41317S2;
	Thu, 09 Jul 2026 23:11:01 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: linux-usb@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Takashi Iwai <tiwai@suse.de>,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH] usb: gadget: f_midi: cancel pending IN work before freeing the midi object
Date: Thu,  9 Jul 2026 15:07:17 +0000
Message-Id: <20260709150717.399083-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgA3cXQFuk9qcukBAw--.41317S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?AjXjigXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnZPoDCNGYdHSfuFmYJL54WNseJI10KMl+AYWHQh9KPBOOoRdUgq00KihadkEtnLD2cdR
	VkhCMNMOCdsHvzZL4Eqp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxWr4ruFW3CrWUKFy7KrykJFc_yoW5CrWDpF
	4fGrWUJF4DZrs0vF4DXF4FqF1rZa13t34kKryUG3yIq3Waqry8tFy8KF4v93W7CF97Zr42
	qF4DWry5urW8CrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU85l1PUUUUU==

The f_midi driver embeds a work item (midi->work) whose handler,
f_midi_in_work(), dereferences the enclosing struct f_midi through
container_of().  This work is armed from two sites: f_midi_complete(),
on a normal IN-endpoint completion, and f_midi_in_trigger(), on an ALSA
rawmidi output-stream start.

Neither f_midi_disable() nor f_midi_unbind() cancels midi->work.
f_midi_disable() only disables the endpoints and drains the in_req_fifo;
it does not synchronize the work item, and the sound card is released
asynchronously to the final free of the midi object.

The midi object is reference-counted (midi->free_ref) and is freed in
f_midi_free() only once both the usb_function reference and the rawmidi
private_data reference have been dropped.  In f_midi_unbind(),
f_midi_disable() runs before the sound card is released, so while the
USB endpoints are already disabled the rawmidi device is still usable by
an open substream.  A concurrent userspace write on such a substream can
reach f_midi_in_trigger() and queue midi->work again after
f_midi_disable() has returned.  A work item armed this way may still be
pending when the last reference drops and f_midi_free() proceeds to
kfree(midi), letting f_midi_in_work() dereference the struct after it
has been freed, a use-after-free.

For this reason cancelling midi->work in f_midi_disable() would not be
sufficient: the ALSA trigger path can rearm the work after disable()
returns.  Cancelling at the refcount-zero free site is the boundary
after which neither arming source can survive, because by then both
references that keep the midi object alive have been dropped: the USB
endpoints are already disabled and the rawmidi device has been released.

Fix this by calling cancel_work_sync(&midi->work) in the refcount-zero
block of f_midi_free(), before the embedded work_struct is freed along
with the rest of the structure.  opts->lock is a sleeping mutex, so
calling cancel_work_sync() under it is permitted, and the handler takes
midi->transmit_lock rather than opts->lock, so no self-deadlock can
occur while it waits for a running instance of the work to finish.

This issue was found by an in-house static analysis tool.

Fixes: 8653d71ce3763 ("usb/gadget: f_midi: Replace tasklet with work")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.5
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/usb/gadget/function/f_midi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
index 4d9e4bd70..fba8cf787 100644
--- a/drivers/usb/gadget/function/f_midi.c
+++ b/drivers/usb/gadget/function/f_midi.c
@@ -1309,6 +1309,7 @@ static void f_midi_free(struct usb_function *f)
 	opts = container_of(f->fi, struct f_midi_opts, func_inst);
 	mutex_lock(&opts->lock);
 	if (!--midi->free_ref) {
+		cancel_work_sync(&midi->work);
 		kfree(midi->id);
 		kfifo_free(&midi->in_req_fifo);
 		kfree(midi);

