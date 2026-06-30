Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF321D9663;
	Tue, 30 Jun 2026 22:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782858201; cv=none; b=Bsaow9qPDix7vPbjV87v3UxkTzrPzl2CJfYrDTM1fxBYQxGMx+l659i9PUMMBjzRMNhn9qQ/gvqBRJbo9KJjmMa5XXCPTmk/MaJ0NR8ek0oNevqij85Gmh0l9k9+DQKoSgO3NvENEh/zI7951XBKDh0Ui0OwcwPPeVjhRLlAOCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782858201; c=relaxed/simple;
	bh=Ku9og58Xz1nANnozikVlC9ErCkL2zdmGYHCsn4BnHMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fuo3G4tUW7lQqaZnwMSjJYHmBmkMndpk/waMAV888VkWZyNr/neNyDzi+ngN5IOmkbd5CMkZQepVzWtSmWmKbH9XhP4Hai+jmZ0j3jwyeiVZ0s3EERjY5vupq41sIHw6JkZm8MG1SU1Jrq85l6TLIyMte6eMoJxOlmOPxPvwQ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGdd5lRw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGdd5lRw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2A81F00A3A;
	Tue, 30 Jun 2026 22:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782858198;
	bh=Ku9og58Xz1nANnozikVlC9ErCkL2zdmGYHCsn4BnHMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UGdd5lRwgO64Br99au6ha83ML3w2JJTl1jmUntTYf7mJjx7+6uDKJq46+pSVfW/f5
	 bonDW/0G2BVMh+c547shoQ9mENUUCWN1eJzy2vBCWtEQQsmMEn7zsRDp9dHGwqa+NC
	 xSJNkr2LY3hatRDtOaPD36ojbAYuX9ikFofgB4xxqKs9jlI9VguuOaBlkc5o96sJzj
	 mPIA6fdovuvBK1usgFHizc7oUtfesCDTBg6MIvttVXZ6EKVsG4v1a2azR13UHQM/f4
	 tCIVh7XyrKrdm38i121RXInbdbY/DKmAs5Wf4A8bpePVLf/YxQehHnRy5tYq3oPrPy
	 p4p04pM2QaGaQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	dhowells@redhat.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	doebel@amazon.de
Subject: Re: [PATCH v2 5.15.y] ring-buffer: Remove ring_buffer_read_prepare_sync()
Date: Tue, 30 Jun 2026 18:23:10 -0400
Message-ID: <stable-reply-item003-ringbuf-515-20260630181642@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630060321.1494832-1-doebel@amazon.de>
References: <20260625054005.0014.ringbuf-515@kernel.org> <20260630060321.1494832-1-doebel@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [doebel@amazon.de: move patch section using guard() macro into a
> separate block to address declaration after statement warning.]
> Signed-off-by: Bjoern Doebel <doebel@amazon.de>

Queued for 5.15, thanks.

--
Thanks,
Sasha
