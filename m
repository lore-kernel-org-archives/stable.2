Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370200;
	b=ckY+ssFtBdfKXTQnFcA21CFHB6V2onf545u8G8O58ZoA7VmknNh70BwAs3Blp/rr+3pS
	 CmKz5dBQ9iZNkiM+dIfHVMj1NPpVYT5y+B1v2RnjtiuIdDBP0VD3FGKht5LqpICOac1tx
	 kvCJuhZd5LsqfTFM2nS7YzXtS10/VlUq/ycqcwShxVeDqDTNMOkQqQAa9PQJ80oIHxMtb
	 8snwImAkIxEXmdLtuCE5+U+L2tn70+Pt1W7jzb5bC7wD3L9Ol77TirQIOV0kWJCajWOeS
	 FB+5WEu73W4P+UVAQxVNfDdIlIOvmvXD40jgGfDbUzJ6IVOpah6vvE9hO5/azOYTrAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370200;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=fY4NiB0lnCmXXvWoHiXa3CSwTq2oIvD6K9iiaXuO72o=;
	b=PTreTEuO+bDEV4BvekcKY7wQM7S8JXEJnVI/Lm4RtHf7OyEtt2PPwtwrg0pA3aYBwoab
	 GcNkXsP4q8TYMBeXM2H/f3XoIigJQOWINI8y2NripkbsUDDILE8iWUUMnNJTYJ8Lpz7sS
	 V7XzveTecfCQwBWD3DFnk06nXcgqPSscf0hZf9XH6HEXbtUHnugwbPywaQl9B03LkTtmQ
	 W+XA1kaayyhP+C0ku8k9y56oMhwvuaDyRhyjk0zP/Aa5syRns/6bRzXQ7jlaXmUDxIBIh
	 sSB6FpQTj+6gSKFqQ//lMIficYhULRFaaJT2IxiDV1JFnFFlVyc941Aecn7fxL4H6aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D47A606A330
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 04:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D47A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=fY4NiB0lnCmXXvWoHiXa3CSwTq2oIvD6K9
	iiaXuO72o=; b=XUxXCna5FCGC56Yu/VVNh4MyW+QVb6TNGJFsDKFkIy2LKg4dZ4
	mJRFFFsIPIxZGEy7qL9qoPrweDFdSaj/L6a7OcmNxND3zKs04DVgPtEe/stTyguu
	GDOP9P/51UW5kB+/jrXbaAu8+hUhjNRnJKl5pLbt55lTTaUy2w/3Sqo3I=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.33])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkBmiwGS6vNq_+ZyAQ--.14204S2;
	Wed, 11 Nov 2026 12:09:54 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: stable@vger.kernel.org
Subject: [PATCH 5.15.y 0/2] ALSA: bcd2000: backport the MIDI URB use-after-free fix
Date: Wed, 11 Nov 2026 12:09:51 +0800
Message-Id: <20261111040953.33271-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109202440-failed-5.15-f6c7bb1f0799@kernel.org>
References: <20261109202440-failed-5.15-f6c7bb1f0799@kernel.org>
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
X-CM-TRANSID:BrQMCkBmiwGS6vNq_+ZyAQ--.14204S2
X-Coremail-Antispam: 1UD129KBjvJXoWrury8Kr18WF4xGr13JF4rGrg_yoW8Jr17pF
	WrWF45Kr1Dur4fZr13JF18Kry5Zws5Ja4qvF1fKr1jqry5WF47Jr4xGa1qka4DKFZ7G3s8
	ZrnrJ3sxCF4DuaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r
	15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc2xSY4AK67AK6r45MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVWUJVWUXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyT
	uYvjxUy8u4DUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUOD2rzNcaM2wACs5

The 5.15.y stable queue could not apply f6c7bb1f0799 ("ALSA: bcd2000:
Fix use-after-free of MIDI URBs on file close") because that patch is
built on 221253723dc5 ("ALSA: bcd2000: Fix race between rawmidi and
disconnect"), which is not present in 5.15.y.  This series backports
the missing prerequisite first and then the requested fix.

221253723dc5 adds a spinlock around the rawmidi operations and the
completion callbacks, and clears the URB pointers under that lock.
f6c7bb1f0799 then takes a URB reference under the same lock in
bcd2000_midi_output_close(), so a rawmidi file that is closed after the
device has been disconnected can no longer call usb_kill_urb() on a
freed URB.

Both patches are faithful backports: the resulting code matches the
upstream commits exactly, apart from the surrounding 5.15.y code that
differs from mainline.  They were build tested with CONFIG_SND_BCD2000=y.

Takashi Iwai (1):
  ALSA: bcd2000: Fix race between rawmidi and disconnect

YuanZhe Liu (1):
  ALSA: bcd2000: Fix use-after-free of MIDI URBs on file close

 sound/usb/bcd2000/bcd2000.c | 62 ++++++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 8 deletions(-)

-- 
2.34.1

