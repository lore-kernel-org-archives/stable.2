Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370189;
	b=XPHLcxgaZeO7pQDba/DOzZmrw/JbdPr0S9PjJjaE4tNHHsIniwzp4N9rmpp5i9tTEKyB
	 rj+ISMZLp4tgDHNkTUG9v6iCVAXCiWAnnlcCh1PzN8IZxNJilSnfBk4A+9nQQbg+WUYGy
	 qqSMQeTQVk7dUVpm4CWI4+yEiOm+iyLNtqiZ01syU/fOdh6lN2YDdQQ9h0GIQeCzG2/8V
	 lMBf8tGD8H7QWybXIVVIVhkJSzpMvABi4oPvJ44hPlWoRT0Ly1NsCJUPClVrTkmsCgdp4
	 Pirio1N16qU0hbG0++M4PE6S0X4A1rbwWb3Z3ua4JOIyZBnZXPqqE0tePYocpV8AKVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370189;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=LnYxcrQT2ADe7H/EXbXhviKiw7OqjBUCy3s+tpRJ1LU=;
	b=H2xaGt90Hl20MZqJNMOM0/+0wUPkizPqqQYnwHGprplvFovodv+oS9oze+Vf5bcx84va
	 hxSeGvPf+o8q2x2KW8GBHzxstUqAyk4ccAlxUNsyFv2E52l4aaflVaheug2IJrKW31KGV
	 Dcg5BInnJ5dXTQC00vKUbEFIKnTEv0zgB3ixjG5dFHmfTb9pSRrnwOBnHDR6HbaTAJ0tP
	 3uRz/2772UzBlEbkWPi2C7JGQ3Q0lEws49i/IPGimCWnurhVFUn5zurvaqSUq/O/n0OXG
	 49+u0NYL5xuB50TlPBLxeO9AyqeG8Hyt0zqWhVIJL+/fuEIO57tZsomq02my1XkCkQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E14606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 04:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5E14606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=LnYxcrQT2ADe7H/EXbXhviKiw7OqjBUCy3
	s+tpRJ1LU=; b=IGuQEVQ/+nGcbSOfcWm2e/XevlPUuuE8RFfe4V3twVOor8wu9f
	ajq4LACzMbAyTnLjziS1CEzyoRYE4S4d6aRvG+kAdJ322ZRW4V966W+/EvKEjD0e
	YycAdpDKX3NYZry2iq3El5bQHUYI1C88z3SY6/9iJUswNcClEC/gJ4bZs=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.33])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkCGifyD6vNqclByAQ--.43367S2;
	Wed, 11 Nov 2026 12:09:40 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: stable@vger.kernel.org
Subject: [PATCH 5.10.y 0/2] ALSA: bcd2000: backport the MIDI URB use-after-free fix
Date: Wed, 11 Nov 2026 12:09:36 +0800
Message-Id: <20261111040938.33215-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109202905-failed-5.10-f6c7bb1f0799@kernel.org>
References: <20261109202905-failed-5.10-f6c7bb1f0799@kernel.org>
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
X-CM-TRANSID:BbQMCkCGifyD6vNqclByAQ--.43367S2
X-Coremail-Antispam: 1UD129KBjvJXoWrury8Kr18WF4xGr13JF4rGrg_yoW8Jr17pF
	WrWF45Kr1Durs3Zr13JF18Kr15Zws5Ja4qvF1Sgr1jqryYgFsrJr4xGa1q9a4DKFZ7G3s8
	ZrnrG3sxCF4DuaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkvb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1j6r15MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07bOPEhUUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUOD2rzM1aQiAAAsh

The 5.10.y stable queue could not apply f6c7bb1f0799 ("ALSA: bcd2000:
Fix use-after-free of MIDI URBs on file close") because that patch is
built on 221253723dc5 ("ALSA: bcd2000: Fix race between rawmidi and
disconnect"), which is not present in 5.10.y.  This series backports
the missing prerequisite first and then the requested fix.

221253723dc5 adds a spinlock around the rawmidi operations and the
completion callbacks, and clears the URB pointers under that lock.
f6c7bb1f0799 then takes a URB reference under the same lock in
bcd2000_midi_output_close(), so a rawmidi file that is closed after the
device has been disconnected can no longer call usb_kill_urb() on a
freed URB.

Both patches are faithful backports: the resulting code matches the
upstream commits exactly, apart from the surrounding 5.10.y code that
differs from mainline.  They were build tested with CONFIG_SND_BCD2000=y.

Takashi Iwai (1):
  ALSA: bcd2000: Fix race between rawmidi and disconnect

YuanZhe Liu (1):
  ALSA: bcd2000: Fix use-after-free of MIDI URBs on file close

 sound/usb/bcd2000/bcd2000.c | 62 ++++++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 8 deletions(-)

-- 
2.34.1

