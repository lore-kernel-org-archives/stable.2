Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6526330305;
	Tue, 30 Jun 2026 22:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782858203; cv=none; b=dhemwWXlJqYOjZnkeK8E25LC75dn0on8EDXeJamnMVasmQ2n4ItODV43LJWrW+QxATO+BLgJCbx3gzloYFuelLp5wls5Ei3guMLBsn6M9GaV//3BmFTn6FENVOS8nmpbD++tRnhcA1xhvSjeg9Bbllz/UXwSXRTzzV0z+E1I9Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782858203; c=relaxed/simple;
	bh=gMi6GiCXi+5Y44/3AH7W97nckwBFvTYTkOkK8fpCYtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GzakwXO2MLaq1oXwDGyxOfadpF0vx16eaR1vn4KNbg1wRexUHtFPY4UW/s4k58892cf3cevw2wPwUu/Fg7KWlXsAKT5NDbOAZCedDLIymbemS2/+R/uDze73rBfw0KL/FQRSyj5MMnlCzPu4Q1fvybQwlsZq65hF4COD5ukhRHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSy9ZMkY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSy9ZMkY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F74A1F00A3D;
	Tue, 30 Jun 2026 22:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782858200;
	bh=gMi6GiCXi+5Y44/3AH7W97nckwBFvTYTkOkK8fpCYtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jSy9ZMkYPkWEsBZpwhkM5S1TvNtkoLu3AsJpOyzM4SXv8U38X8TB/V3r7FyufBzZ6
	 VlJBneWvOI/mb2f0WYS/DPkkC7WNqtU1c4Kf5b5JO8e/DJnPyhRgzkRBUXzxaVKuU/
	 TFuaSpmfKaP+7sw0tsntx11J0HPNDB/jz7CFyuFeReW5g7Uc1byQNpWw6HKq7itlQB
	 Dzv+N0NK/iaSntAxU5YEpHfpSuTcMINrjlZidVu313UntbjRZHBenlUwKl//WjdWyp
	 0Ht7WmLbObPpcsHYZcrTTXtYyPZ+4IMbX+Cl1rSXkT0cv+VyJBlfO5NkpdiusIBfmF
	 72eVEmqN15Vvg==
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
Subject: Re: [PATCH v2 5.10.y] ring-buffer: Remove ring_buffer_read_prepare_sync()
Date: Tue, 30 Jun 2026 18:23:11 -0400
Message-ID: <stable-reply-item003-ringbuf-510-20260630181642@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630060634.1496989-1-doebel@amazon.de>
References: <20260625054005.0015.ringbuf-510@kernel.org> <20260630060634.1496989-1-doebel@amazon.de>
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

Queued for 5.10, thanks.

--
Thanks,
Sasha
