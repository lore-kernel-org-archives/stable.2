Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.14.198.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606493;
	b=N+br72ZQaBIr0Y4PopTsXzfE3ReFMe+gcQwuH8E3xy0j/tSkUUrL56bcAsr64213wBfx
	 MYX2UcxIOTiAZpPlW678ge3ZhejkxuFPKCxOvXrElPr+QJzHwi5W5t76qbSBcect5Hijr
	 8vsEgENx4fhcpg11KCd+vNwI0Gvg5BLs9ucwIqmiCFKMolh/pbCN5201C6dLuHUKkyIbH
	 75WJuFbFIOwFTmkg/PPVAoU8vBEcOBy9Nbt3thQwKo+ig7wtP2oeBzzSjbvtt5C9oVP1V
	 CHRVtUNV5mElGok5SRMweqr4o/h7OgcqKPl9a/AtLcgUXQQGESLskpSIc879TGV5gKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606493;
	h=DMARC-Filter:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Received:DKIM-Signature;
	bh=xh6yLZbkfG5phrFUltitLNIUO1sbdHLrePH/xJi7t8U=;
	b=C9osDEjxIsQ0G9yHPMbzfxQTbVHIXGBvYuxfMgvzdJcWOSW9kubAPUq6mbLyddJFI7w5
	 liwc3ri+l4LF+IYXrzlHVp5GAC6mcAnL5cayUZLwM9LlF5UjBPcwQ1Em+l9dVSj72MiBj
	 X9O0x2kTDttxX1vRTBJSWO/wifin5q4C74HeajXEMGOFhfrlM0W8TOtNoGXZJRf0VcKU3
	 QMOCuKdOBB57zkW8c/jxaN7iC9OekGcjHJizgZmfVqDZvdiAwFuVPMTqXvX2JVpN53u+X
	 6jqAG3tI7lKPEnGW1SdlYxPAX4ynFUcudMOroRR03Yu6nkCbgPsfXgozWnRtPaKTPyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rimpianto.com;
	spf=pass smtp.mailfrom=rimpianto.com;
	dkim=pass header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b=Z9Jpm39s;
	arc=none smtp.remote-ip=46.14.198.178
Received: from mail.rimpianto.com (mail.rimpianto.com [46.14.198.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6AB606A31E;
	Wed, 25 Nov 2026 11:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC6AB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b=Z9Jpm39s
Authentication-Results: mail.rimpianto.com;
	auth=pass (plain)
From: Federico Musto <federico@rimpianto.com>
To: netdev-bot+sashiko@kernel.org
Cc: Federico Musto <federico@rimpianto.com>,
	Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v4 2/2] net: atl1c: free the RX buffer when the descriptor reports an error
Date: Wed, 25 Nov 2026 12:34:49 +0100
Message-ID: <20261125113449.99968-1-federico@rimpianto.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <179530311840.3135.8141689247648916052@kernel.org>
References: <20261117225521.19689-3-federico@rimpianto.com> <179530311840.3135.8141689247648916052@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received: from localhost (Unknown [127.0.0.1])
	by mail.rimpianto.com (Haraka) with ESMTPSA id 1557B4B4-8BAA-4169-AF81-D2364685FB51.1
	envelope-from <federico@rimpianto.com>
	tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
	Wed, 25 Nov 2026 12:34:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rimpianto.com;
 h=Content-Transfer-Encoding: Content-Type: MIME-Version: References:
 In-Reply-To: Message-ID: Date: Subject: Cc: To: From; q=dns/txt;
 s=s20260314391; t=1795606489;
 bh=xh6yLZbkfG5phrFUltitLNIUO1sbdHLrePH/xJi7t8U=;
 b=Z9Jpm39shMnyRZRdj0QvqDo+21OdNPHnSsnJ7QQvxP2Y16RdrdCb7oaiP+ODDJAPq0ZKZMXys
 lSqkDIVLyMIsmXgZSO72cbe7ar/TeDmqpeWP6l+9mGZ5cT7tBJWAE+X8uGEI92x/vSzPyP3qIcT
 MrFdiGx9VZYLqtHlzw1kiRmMkARmd7Kpf6eGl8ciQmh5lRVYboLjKQ9SztOnrnF+y5j905tAFJ0
 VMYTAgUzh55EbMfSYl6ycBzem24psD1Q/IWC41Ag+2jLy6WaoD3RU8TrnXcgyCMnsoyDw1/pzqL
 h+I0fU30kNXMfc+6+fRN9b114cDyP6R612CLd7gOzbKg==

Thank you for the review. The findings are addressed in v5 of the
series, posted here:

https://lore.kernel.org/netdev/20261125113120.99743-1-federico@rimpianto.com/

[Medium] Missing dma_rmb() between the valid-bit test and word0.

Correct, and material for this patch as argued: word0 now decides
whether a reset is scheduled and the ring is zeroed after a reset, so
a stale zeroed word0 would schedule a spurious reset on weakly ordered
CPUs. v5 adds dma_rmb() after the RRS_RXD_IS_VALID(word3) test and
before the remaining descriptor reads.

[High, pre-existing, new trigger] schedule_work() lifetime.

Correct, and since v5 adds one more producer of common_task, the
missing cancel in atl1c_remove() is now fixed by a separate one-line
patch posted alongside this series:

https://lore.kernel.org/netdev/20261125113141.99792-1-federico@rimpianto.com/

It adds cancel_work_sync(&adapter->common_task) after
unregister_netdev(), where the IRQ is freed, NAPI is disabled and the
TX watchdog is stopped, so nothing can queue the work again.

[High, pre-existing] common_task reset path serialization.

Acknowledged and still deferred: a full fix requires reworking the
serialisation of the work item against the rtnl holders - the same
deadlock is why patch 1/2 does not use napi_disable(), as its
changelog explains. Planned as a separate series.
