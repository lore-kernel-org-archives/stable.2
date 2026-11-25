Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597727;
	b=YdWR4AXTKUpsntrkUQXLA9OuILoSRcj8+DNPwTdD7uOGXiB9z4CyqlATgQ2FPoV0TA3Z
	 aiyZNeYYsSoQa6zusJde7v3ysUkFwsNccjTs96hG1MaweOrnQ1xc1uTWrSO2qWnzlBRFv
	 p2C7ARBGV4samwFjjeI7o7yHk/lWwEMYWGTjkWKfOZ8Cp9feDXkgAYqfCsBru8bxveLlA
	 hYP8WSKVj6YpowV5aTdEqoAxnIdRVZOtdiFC5tVmViLNn4vGVjsTFgoXj7+gVFDr2K/82
	 T6hJRQ70He0l2j5xXikfI5FalwvsOBAgEp2edvd0yrLoORjdbL/a1DoJHSuucYI3uXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597727;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=AVxa9wNqzpor2S7o18/l49o4PJSdrJGbHuLndqGm64A=;
	b=WUH7TCC0d6SwzGVnsEqB/JnPuC4bZgzo1lY2utyUVHox4lJ6NB+4/5d6pxUr5UFdat5c
	 yDNzeXhgv17vAPOnL6E5aI3cUnIHgOvSx7W5wwsW9y5ChCmWmKC35nWd9NfkWLsEg1OmS
	 wvdeY+MYuTb+w/wRKpkyCAH9bsDJCE5C5jnR3oB64x0fBaTRb26fRcwN4/j4swhUt+omt
	 kzJEUcxGY/JNgM9PW11nWU7AUQoJbov+UWrl5Mr7W3XuHZKESvpxk6poZsfIjmxK8A4oz
	 wJsK4sVyCJnIUTP/7vJkAD/3hc3kzcnW3RQ11p0X1qD9rMeC1rzKj115gkgqZLhnlJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687F9606A68B;
	Wed, 25 Nov 2026 09:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 687F9606A68B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=AVxa9wNqzp
	or2S7o18/l49o4PJSdrJGbHuLndqGm64A=; b=GC40UAoaeZ+7Z8yLCQD1hZNlWv
	8EZrTvVOVv5Wp4eKFZn5s2+5s3zyDpNPv1XU25RrnZzJNC9Y6mjIppIhovQpk6MY
	hMr41n6Wr6sPloRYs5ETiBPRFzNQyS0Wh5otChaJwnD1RGsvodg/pfh5b2EzjGXb
	QmUFhH0+9XDD6X4hI=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.108])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkDW_wWPpQZrDPEzAg--.16377S2;
	Wed, 25 Nov 2026 17:08:32 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH] media: siano: free the smsclient after the DVB devices are gone
Date: Wed, 25 Nov 2026 17:08:30 +0800
Message-Id: <20261125090830.8243-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BrQMCkDW_wWPpQZrDPEzAg--.16377S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1DWr1ktw4fJrWrKFW3Wrg_yoW5JFWUpa
	95CayjkFWDKr47Cw4DCa4xWF95t3Z3XFW3C34UWr43t3WDGFySkFZ0y34qgr1DJryfAF4q
	kFn0gayjva4UAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvGb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjxU4CD7UUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUID2sFqFm2rwAAsF

A KASAN slab-use-after-free read was observed in smsclient_sendrequest()
when a demux file descriptor is closed after the Siano USB receiver has
been disconnected:

  Read of size 8 at addr ffff888006067a10
  smsclient_sendrequest
  smsdvb_stop_feed
  dmx_section_feed_stop_filtering
  dvb_dmxdev_feed_stop
  dvb_dmxdev_filter_stop
  dvb_dmxdev_filter_free
  dvb_demux_release

The object is the smscore_client_t created by smscore_register_client().
smsdvb_unregister_client() frees it through smscore_unregister_client()
before the frontend and the demux are torn down.

dvb_dmxdev_release() waits for userspace to close the demux device nodes,
and the close path calls the stop_feed() callback before it drops the
device user count. A demux file that is still open when the device is
disconnected therefore always reaches smsdvb_stop_feed() after
client->smsclient has been freed.

Move the smscore_unregister_client() call to the end of the teardown,
after dvb_unregister_frontend() stopped the frontend thread and after
dvb_dmxdev_release() drained the open demux files. At that point no
callback can reach the client any more.

Fixes: 2e5c1ec8865a ("V4L/DVB (8258): add support for SMS1010 and SMS1150 based digital television devices")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/media/common/siano/smsdvb-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/common/siano/smsdvb-main.c b/drivers/media/common/siano/smsdvb-main.c
index 415c24fbbb65..245cd26ab7a1 100644
--- a/drivers/media/common/siano/smsdvb-main.c
+++ b/drivers/media/common/siano/smsdvb-main.c
@@ -655,12 +655,12 @@ static void smsdvb_unregister_client(struct smsdvb_client_t *client)
 	list_del(&client->entry);
 
 	smsdvb_debugfs_release(client);
-	smscore_unregister_client(client->smsclient);
 	dvb_unregister_frontend(&client->frontend);
 	dvb_dmxdev_release(&client->dmxdev);
 	dvb_dmx_release(&client->demux);
 	smsdvb_media_device_unregister(client);
 	dvb_unregister_adapter(&client->adapter);
+	smscore_unregister_client(client->smsclient);
 	kfree(client);
 }
 
-- 
2.34.1

