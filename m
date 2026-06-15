Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896763AF65C;
	Mon, 15 Jun 2026 06:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781503884; cv=none; b=Wy4kI9ckSdHy74gTXbLg+3b30g5iu8rr/QIEUwFAagiDLY2DaZNe9FUQ3xhoMIzU2UJXxoRxCjun/qURYhtAkCVNaYpuYKG8i9Q0CmtcaTPiTW/oMPkVnIUKgXmTHY69JcR7rjMK4osjAMPqHhWJ998FLSCkRJMgCSdsjyq2nh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781503884; c=relaxed/simple;
	bh=IKFQJZ2rcM5VGT41bxkBMTa5XBj5aJ3t2zTnTTGoqvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cyu3fEFKTFxLIG0XCPiYA2YGIVrnx2Af6jG5nWDftJEx5km68eFtp7Eq1aXNWEDZ3HeezmLwZlLEMRqGgVW8WB9N9pc1UcyX6K4GbqiNp/CaKw8xFLQGw4Mq8tPnxl+3yhSsaYvyYgE754mPT20tMIAuQl0E0zXI8PmbM5haCAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=M+vB9Mvo; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="M+vB9Mvo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=LLe8r0M8kVzK4RUW49U9dZFwBdCrOZ48uT
	Bo2j0abfs=; b=M+vB9MvohVqWP0Bm2dRz5MNKb23NYZm5wPhKRloAqsxRlMDi6J
	2ZebcbEHJom8TDrB25B51TmcfSNpriAfvbMvdTP+tQpQQyVBEwrJOoDxZVvYBoI1
	Gtrj/4x4uaHh9LQqDh8Ry8UGZW1vJ+5urA2nrVZjMNABgUb9J7JmsvyKQ=
Received: from localhost.localdomain (unknown [59.66.142.89])
	by web3 (Coremail) with SMTP id ygQGZQA3hJFvly9qZMNyAg--.13458S2;
	Mon, 15 Jun 2026 14:10:55 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: andrew@lunn.ch
Cc: 3chas3@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	fengxw06@126.com,
	horms@kernel.org,
	kees@kernel.org,
	kuba@kernel.org,
	linux-atm-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	qli01@tsinghua.edu.cn,
	stable@vger.kernel.org,
	wangao@seu.edu.cn,
	xuke@tsinghua.edu.cn,
	yangyx22@mails.tsinghua.edu.cn,
	zhaoyz24@mails.tsinghua.edu.cn
Subject: Re: [PATCH net] atm: br2684: validate IP header length before filtering
Date: Mon, 15 Jun 2026 14:10:55 +0800
Message-ID: <20260615061055.30419-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <e85fe7cc-05d1-4fb1-a919-baa170d08307@lunn.ch>
References: <e85fe7cc-05d1-4fb1-a919-baa170d08307@lunn.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygQGZQA3hJFvly9qZMNyAg--.13458S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw47uw43Ww1xKr18GFyDZFb_yoW8uw4Upa
	yfW3Z0yF4kt3WIkw1vka13A3yrtr4jya43Jan8KrWUuw45JryakrWfKFZ8K3srCr1kZ343
	ZrWDXw1UAa4kZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcx
	kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8
	Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
	AqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xS
	Y4AK67AK6r47MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GrWkJr1UJwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUHKZAUUUUU=
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAQATAWovKbDInQAAsa

Hi Andrew,

On Sun, Jun 14, 2026 at 08:36:57PM +0800, Andrew Lunn wrote:
> So did all these people find the problem at the same time in parallel?
> Can you point to their reports?

No, they were not independent reports found in parallel. This came from
one internal analysis/reproducer effort, and I do not have separate
public reports to point to. Sorry for the confusion.

> It is a long time since i worked with ATM. From what i remember, ATM
> cells are 48 bytes in size. So can the packet actually be smaller than
> 48? Would a 48 byte packet trigger this? Or is AAL5 involved here? Can
> AAL5 carry a frame smaller than 48 bytes?

On the cell-size question: yes, ATM cells carry 48 bytes of payload, but
br2684_push() does not receive raw ATM cells.  It receives the
reassembled AAL5 CPCS-SDU/PDU from the ATM layer.  AAL5 can carry a
shorter user payload in one cell by padding the final cell, with the AAL5
trailer carrying the real payload length.  So an 8-byte LLC/SNAP BR2684
PDU can be carried in a single ATM cell with padding, while br2684 still
sees skb->len == 8 after AAL5 reassembly.

A reassembled 48-byte BR2684 PDU would not trigger the issue in the LLC
case: after pulling the 8-byte LLC/SNAP header, 40 bytes remain, so the
IPv4 daddr access is in bounds. The problematic case is a reassembled
AAL5 PDU shorter than the encapsulation header plus a minimum IPv4
header, for example an 8-byte LLC/SNAP IPv4 PDU with no IP payload. The
VC-routed case is similar: the current code reads iph->version before
checking that the reassembled PDU contains an IPv4 header.

> What hardware was used when finding this problem? I know DSL often
> used ATM underneath, so was it a DSL modem?

I'm sorry that no physical ATM/DSL hardware was used. I verified this in
QEMU/KVM with a small dummy ATM device that registers an atm_dev and 
injects reassembled AAL5 PDUs through the real VCC receive callback after
BR2684 is attached.  That exercises the BR2684 receive and IP filter path,
but not a hardware SAR implementation. However, this is a real logical bug
existing in the kernel, but it is not verified that if it will be triggered
by a real hardware.

Yours Sincerely,
Yizhou

