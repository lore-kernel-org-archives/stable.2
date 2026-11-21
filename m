Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795279777;
	b=rmodtH4p6jocdmUSqSvseXAlGf/Q8i8ZrA5J5zgR2n5rQLh5896iv/QNe1OoBqdoN9Ye
	 n5LOrtgHyQRW7HAxZRvFeyAnCn9C3fDS2/AaXCMV1x9iQEEszlblcwv5/7gdYKjTgrY+X
	 EIg8cKIOueMyaUENOOPtczjWYu2FgohQoPPhDrxQYastwhKQFbwYoCT+5ndOfPOt57V9q
	 Ans682lj2Nt6yutL2Itz33hS4L/S1RnsGqLOs7C0dyxYDpkGaVGKL+M3Hwdx/15zbfyaF
	 YklDiinOI5n9zM1tLZiM7Hxb1/+QUS22Mty8FGmJ+RAIDvlgRehEeaTnfsltcpp32Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795279777;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=R7fX+Uz+QNYUv4vkCcnO4HudXcK/0BmjU5Y0F9HVjpg=;
	b=hpdoUDY7VH1P3VhXMmAk38cSemr0IWgb9+VG7plEUlWApjb5kiTg8M/uk8MXLB6h2PZK
	 ERY9ugKp0m03eDbbMXI9AZVRPyXzfpsLF/I2T1L+uhebjoqMcqXWlJfjKC9UC0OmjpPF/
	 tuiS9EZfAMjDUuNkuLRWdkUyRUluGs5lw4lr/MlGhKYVnpCF7zKvIROe9cFAM9ldDiH8/
	 KX07mZxSCo93XbhcWaWF5DS4X2beDgxPptz6A8cWRHQupplm3FTcEgjAiPFLNT6Ds/T1N
	 cCQvyTTIDoe889oekZXkcQfTr4vWc6i/kyY6BET7ci3c4tV0Bx36TuxyUy2xR95V7cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D40606A32A;
	Sat, 21 Nov 2026 16:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91D40606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=R7fX+Uz+QN
	YUv4vkCcnO4HudXcK/0BmjU5Y0F9HVjpg=; b=knZ7hRRL+CXHq8f7cu76Vvi2FY
	vMYq0AGos3vOPBLjCp9iopA0OPm/UeBVnT4tkxwdCOsxYFU3QCHM59id1/xLlzVp
	b0p/o/ofj2fDVRJyshJhwKIIHRQz5HsMGYyDB2QZTw6a+s4aivH6H99jJATwkjB1
	6QZJJJSFAaCbySQEA=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.70])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkCGyP2UywFrA1QFAg--.46581S2;
	Sun, 22 Nov 2026 00:49:25 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Arien Judge <arien.judge@morsemicro.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH 0/2] wifi: mm81x: recover from bulk transfer errors
Date: Sun, 22 Nov 2026 00:49:21 +0800
Message-Id: <20261121164923.8862-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkCGyP2UywFrA1QFAg--.46581S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKr43Zw1xAr1fGw4ruw18uFg_yoWDXFb_Za
	48ta97Xw1UW3ZFkFW3Gr1avFZrGay2v3WUAF1DX342y34UJFWkAFsYkrs0yw1fGa9YyFn7
	Ww1jqr1ruF17WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaxYjsxI4VWkCwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z2
	80aVCY1x0267AKxVW8JVW8Jr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28I
	cVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx
	0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY
	1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07j3WrXUUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUED2sAYljOOwAEsv

The MM81x USB driver mishandles errors of its bulk transfers in two
independent ways.

Patch 1 makes mm81x_usb_cmd() report the status of the completed command
urb. Today a command that completed with -EPIPE or -EPROTO is reported as
successful, so the data phase is submitted even though the command that
programs its address, direction and length never reached the device.

Patch 2 clears the halt of a bulk endpoint that answered with a stall. A
stalled endpoint stays halted until CLEAR_FEATURE(ENDPOINT_HALT); without
it every later transfer on that endpoint fails as well. The command
endpoint is the same endpoint as the memory write endpoint, so patch 2
builds on the error reporting added by patch 1.

YuanZhe Liu (2):
  wifi: mm81x: report a failed command urb to the caller
  wifi: mm81x: clear a stalled bulk endpoint before the next transfer

 drivers/net/wireless/morsemicro/mm81x/usb.c | 25 ++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

-- 
2.34.1

