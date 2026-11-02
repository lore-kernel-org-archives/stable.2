Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793627975;
	b=PHKNqmeFjEb5IIm46KScv9rBfGeZB7qEBzyLwTjyqk8S9LXZ/ulmtyOFEc2ePVdd7RX3
	 UFRRLspCtRQ0Tob/pLg6xmqZ1uk0omE/EP4S5+xBBjf90IcOhkDPt8rDQD4OF2nTS6JO1
	 dF/5Np3ar8fhdhmyGacWleapDLchY+RXRGu7zJrGtQxJxYDTtusaabpyL54JdWeODDYks
	 qLqX8ZC1Tsg2bObsppo6QQ6hSYzcCqtUCMAaBgQzu0eGm9taP8hdb+A0WrunbtpiBfVlx
	 wfUPR4gyMP05iBw2UtmKjIOPBY5ujpK91ZYQvhQqan2ju7/7Xu/xQRqiEstxUuxMNAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793627975;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=S2d7OdEO5Uy3arxUL89OA5ZZcKM4fqZIMbcJ+h02Lps=;
	b=PWBdEOhNKPDrNaCkWUFD0dyrqxtQPpCVMZOaUSJmkcKY5UToI2icw8DoB3+nlvax1Dux
	 cMMDWAt4P2HRdeeDy1KdNWOrJCluu4oUdA4eZ7SFeLOF40l6PM+2FwfRUVWkDaHaEaOgJ
	 3pXNKsmukEqzBcYf5krroaWTr7VEt2bK65M5sVEPNJOZiVWMsP4IgNle7HYn4aCrg9H9r
	 xk9cAXcQII0dUTKmN4Kt/8MTepOMjq+d5ut2xKzRE/tYWmmdV/AjouMW+Vow2Og91hGhR
	 n63+ptanq6IxclTJRo2LCQiH4S/oGCy1SDqRT7xXye+OfldlP7+Ber2iyBvoQxZAizw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oBUnxIfJ;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27810606A329
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 13:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27810606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oBUnxIfJ
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48c4649b35bso2948879f8f.3
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 05:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793627972; x=1794232772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S2d7OdEO5Uy3arxUL89OA5ZZcKM4fqZIMbcJ+h02Lps=;
        b=oBUnxIfJDoTZEByopHtEIdJUz07MmRKUaOQlkZrSFrJ6mML3CxCbB18dGoaYnGq9Vs
         pTOhEao7IAJrPqBvsd8MQDNNWlYs/e5e6z71xIxUoB1IGN3Y5JdagVUXIPbx24AGPbFv
         YFJbTrgXPE5Ed3Se2V7RQfOWd5ZOxah21CKOVc+IBQrcAJVVD5xA0q3n18X9wP0n6nEb
         cZ/9SgaF99UQAK7Lb1rUDImy7wEdptuQWjdGz4718wSaLxnpX0zJTaZFVWf9zz+qkKwh
         EI12EzgwYLDcf10HIn78HuD+UKeOJh86v+6tcH2yfyo9UvEhbHBNRxVNLTaW6/mvlaJL
         QivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793627972; x=1794232772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S2d7OdEO5Uy3arxUL89OA5ZZcKM4fqZIMbcJ+h02Lps=;
        b=gm/2gr12mRxL3VUr3gNbW2jnmAzhiktihs4viFUn+FwmNA72EvO6tc5mknCn5abdoF
         8aLtJqUIj2m6D2MeK74s+lGnujOCLXcthFW5nm5Cmz8MQClRO5P27/5XxkMrqu7yUGfS
         nalyTvPUilc9tWQHQkDw2gNyQzBQeweOd5jwBvMzm4iOFCVdZjptJsvoqVhrVFZsf8/8
         kdCzx3lRv7L1YFa6JmAR4LmN2WEH3dLpnc1YRtPyL4mCWcmKWATt3DFAZzgB3lisvste
         3ACgbzWDGz2sFslspFqwq+pDJCZHxKs7PiXqY+o8eXMvYwq/aBpAag1m4pU/IlI1a/bt
         RHlw==
X-Forwarded-Encrypted: i=1; AKwUvByyXeMkRl96HEWV+ECgbvv8Wfqd4fFuFEssFuWZ00QLnuoeHtX2d9/cYtEUUUQFgjeJAMkknVw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJaG0fkCTisYGxLDAYsKj1AA40ly99RDayAhcXp+FGcDlCFj8IT
	Y9si50uaDxP08AsstZCSAslWoIUYLQFxe/frOObFFMcWdXSikc0CQbQ=
X-Gm-Gg: AYBFou2gY5CrxXepUeyjIFAZOtOdH+E2G52/85+aLdsrv9AwIuS2hXEEo7D+8fFOD8L
	OOsCl10K/VSsp0aQdep4cqwi4lYuUGrw01Gp8tKVrP796TzFG5Ttu2wP7EkVdx71B5sWh5ufJ2u
	P+k0/qAA+6O0PI4wAfmy6HR/lxzVoM+vKs5mlL5iDmE6TheaM3bPGsmKV97buR5SNWhaLJrcsCA
	7WxXKVht9m4u1fXW29jF1cfyC6VDMC900hOATWr+1xckgL87/q1rqEQ+7H4T7EglYdwDKSdqsWu
	hw6/75DyuwiWimjczKIPoRH3ZZNpAQ9t+S7KOLfwdkDHuXKaF7N6CEfnsd6MYSVmQPBltxnr+Qu
	GeuuJuPvGeO0FTGrNUBgkMFhy/V2MmAPxYi+4vP3CmZXijm1tw9lSQvl7hgkAI/yr4KGjPP6Y2p
	8EkO3KpU3KNMjLTrQcj3Jkw4uMfPCwfhkkWMwUZOk4iYby0JwD4cqPfV9B0W2cTBfFRLq0/y+Ej
	vwILT4isltvWL4ueWz6HaJXbSebl5noTpjLBekFbUYk/XYynjLXHCtgZdxjdIGnYbuyEjj4TonW
	J+a67pacc6A=
X-Received: by 2002:a05:600c:848c:b0:4a1:f99e:f22d with SMTP id 5b1f17b1804b1-4ac17471091mr246374955e9.6.1793627972424;
        Mon, 02 Nov 2026 05:59:32 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf6e63e0esm352680265e9.12.2026.11.02.05.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 05:59:31 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: briannorris@chromium.org,
	francesco@dolcini.it
Cc: bzhao@marvell.com,
	akarwar@marvell.com,
	linville@tuxdriver.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH wireless 0/2] wifi: mwifiex: validate firmware response sizes
Date: Mon,  2 Nov 2026 13:59:28 +0000
Message-ID: <20261102135930.701845-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
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

Two missing bounds checks on firmware-provided size fields in mwifiex:

  1. ext_scan event: buf_size is used to determine scan response
     parsing length but never checked against the event buffer.

  2. command response: resp->size is passed to individual handlers
     but never validated against the response skb length.

Both patches add early validation that the declared size fits within
the actual buffer before proceeding with parsing.

Tristan Madani (2):
  wifi: mwifiex: validate ext_scan buf_size against event buffer length
  wifi: mwifiex: validate command response size against buffer length

 drivers/net/wireless/marvell/mwifiex/cmdevt.c | 14 ++++++++++++++
 drivers/net/wireless/marvell/mwifiex/scan.c   |  9 +++++++++
 2 files changed, 23 insertions(+)

-- 
2.47.3
