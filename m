Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793350319;
	b=BTPNAwshSMigd8UigvACY1wdVo5c6igoNO7M4PrHcZkWbe2a0X/OnYLeLcXsR440b3X3
	 1DAPnZjcUENlwke9cHbP6W/akxY8QRmRcERGti3w/QhA8odnpGN4nPR5FdaNG1B6gR14q
	 /i3dFMM9x/eMXoOOo21ybLmh2ItRfYUmOYwuWHBCGMMpr+xkEtPTyhOZNsWJfET4ut6wo
	 YLJC/zFGjF62KKr6kdSOjCdp3JKN+PTLS03M+TNCQ+kG3Pmzq6Ct8+GLkC9kZ52pMOacS
	 fXP0a3gLup8aQB38zkFkxSpQazBSCMzkXY34jL9RKAbjaN99Vf0Alii/gl9NA8WKbzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793350319;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=0oSq+3LLDBfPlE67BXqRyTf7xK6kh5Hzn6KVpuLBcz8=;
	b=Ys7Atoxqo0cgtMSg4m+MTh/A8hHtn2tAw7I70FhavTd24Uv8bSsarYwIFWgXdZQ99zWd
	 aGf54e7y/v+GNvVgV4AG8Uy8O9wCEjmA/4tjYUzLNdcP+UnGrj343oI/mxLonnqSb1b+8
	 O6yMHfM9I9erJICeYSlPUnQwyFoNkEFTD6J/8Cb/Gl4+HTGASE4SzmMQYQrTtYpJWMyHo
	 XSRBONi/vgx6dzxHwo1lZADbQSWx/3+mPzXyPIc0vUZBG93OJyMZ9sGMa+W/pw6hiwnof
	 3jWVFLXmVfcDIZ48LH7kt0PA16beeQYLVKrOBjhbAPZ/YhdZWBHPaNdea8kBPxbG4jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=dP24nbHp;
	arc=none smtp.remote-ip=162.62.57.210
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241C4606A31D;
	Fri, 30 Oct 2026 08:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 241C4606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=dP24nbHp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1793350312;
	bh=0oSq+3LLDBfPlE67BXqRyTf7xK6kh5Hzn6KVpuLBcz8=;
	h=From:To:Cc:Subject:Date;
	b=dP24nbHpWtVr+PLB1ag8/a9CvMJMgdONEdmMEjufvMe9M8yddOhRzrfcX5LI+s9Ih
	 2rfkOkwLPzMZanC3mmmQ65vfJsx2ZX6J7qf/Z5/HdSPDdD8tHOZS7GAAu9PBwpI2LE
	 thS9QFSZ0nIEFIVRkuDoX+m4dmD8BmW7tAmEKJZ0=
Received: from HAPYCAO-MC1.tencent.com ([101.226.143.246])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id CF33741D; Fri, 30 Oct 2026 16:51:51 +0800
X-QQ-mid: xmsmtpt1793350311tjpg4h2rs
Message-ID: <tencent_AE37F59DA9A6DAB192F6BAFD054E584FAB05@qq.com>
X-QQ-XMAILINFO: NPZcszwnKSXOXkHC8xBkb7B9lkn4bAAchtUelJJjMwG+UCfRctxocScpGz755R
	 CJ9urG9jtT5eKihPldoh5hd8/6FgpueCZAt5yhyCRrq+Lks22HETtGXy0A9A4FW0+N5bTWZfFn4g
	 8x2HWVDdtNKBqKX1HNPueCCBdAvBerJkgOJoC9xrrAlRri/sTLEXqz5EIYEyVk1sDWuDFriUMZYW
	 UAuSMrWlnYSAXQ0bn+somXQngeOTi3ImTzdZMGwmksC+UY3HFquiuoHv53lRg9SIVrVeYbjA77O5
	 YsPqOm/903mGXU40r/ah7DFdq/oUwawLEYsqQcOZEnVF2u28OYvrSvkoe5InNyfW7cbUiMNt3+45
	 jf44Rzu0V7RW6zCeu+/T6tp2G+vusYJdpm7ZaS0JRMkLKdVKC1LojamlmWmvu8hQgRz9svCxp8/V
	 +1NzEvKuEHJ08snhvVlYUulbFkn3i6tABl+AvbWrBnnfGYiqMDBzjJC5RpySNahqdZFTQRMtiB2W
	 LtIlfm/vkMHOAxGbiEOa7D9KSINIyKxyRiC/5qndBSaMWC5j5jpIpJBW2s3Se/02ReG8to7noSho
	 KK2Ec868CcE+wSnVliiN5HSoebyThYGZvq8uOX4aOJOguwlhQqjodQbIr8WMSdMYENqFTpKiJv+o
	 bnGI9FCrOWNQB/9dPfN6pabGz5DIOS+6XPv1upcyfe+cJsb+K0IvB1I1uvqvSJYGZFuiXEeb5t1P
	 wcQXDchHz6el0ND2N5X/v/RQIjS0r7pf9Cbj+B6utT5R/9UuaKPqv/j96Llvdja69EodaPhOc0gw
	 neaTGkQskSmg+ciUYoDsDxCH5Ch9sCnh/kBiiYpdPpAFAM7O3nuF9R7CF6gsm10/gzv0/e4z/ImN
	 rD6evQtoQ8HRmcC+BTRixWQ1dPoQlwMf2AyZDNXZfFhSui1XS7eS/cOH745z7+oHHNuFIxKUc+l4
	 /GtxhwRGIjeFWkxiV5xm1RUWe+2a0i4Z+vDRQBvEz5l/LFBtJjs/kO8Okh8aZ7rUGCGgXgIutaLU
	 Avs0z/aGI5dMGfVGZQq5xnmXssb9FurZ+680hliI4THWh+7zzf9eeeJL1SiUUSUgb4yK4EGQ==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: bo cao <treebacker@foxmail.com>
To: srini@kernel.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Subject: [PATCH v2 0/2] misc: fastrpc: context lifetime fixes on the glink response path
Date: Fri, 30 Oct 2026 16:51:48 +0800
X-OQ-MSGID: <20261030085150.75870-1-treebacker@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

This is the public follow-up to the report "fastrpc: use-after-free
of fastrpc_invoke_ctx on duplicate glink responses in
fastrpc_rpmsg_callback()" (source analysis of v7.3-rc5 and current
master), incorporating feedback from Greg KH on the originally
proposed single patch:

  - split into two independent fixes, each with its own Fixes tag;
  - the atomic bitop and flag bitfield are replaced by a plain bool
    checked under cctx->lock, together with the sequence validation;
  - brace and comment style fixed;
  - kref_get_unless_zero() at the lookup is kept: the lock protects
    the IDR but not the context lifetime, since the final kref_put()
    runs outside the lock and fastrpc_context_free() removes the
    context from ctx_idr only after releasing its maps and DMA
    buffer, so "found in the IDR" does not imply "refcount > 0".

Patch 1 pins the context found by idr_find() before dropping
cctx->lock and runs the sequence validation inside the critical
section.  Patch 2 makes the response path one-shot so a duplicate
response cannot consume the in-flight reference a second time.

No runtime reproducer is included: triggering requires a second
COMPLETE response for a live context, i.e. a buggy or hostile DSP,
which cannot be produced from the ARM side on stock firmware.  The
sequence check added by 96e62cc0a84d already addresses the same
class of misbehaving remote responses (the recycled-IDR-slot case);
these patches close the remaining cases (duplicate delivery for the
same context, and the unlocked use against a concurrent context
free).

v2 is a resend of the two patches previously sent as two separate
emails, now properly threaded as a series with git send-email.  No
code changes.

bo cao (2):
  misc: fastrpc: pin invoke context at glink response lookup
  misc: fastrpc: consume in-flight reference exactly once

 drivers/misc/fastrpc.c | 40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

-- 
2.39.5 (Apple Git-154)

