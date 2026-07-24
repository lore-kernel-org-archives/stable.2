Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FC43C378D;
	Fri, 24 Jul 2026 21:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784929943; cv=none; b=aDckaFOYY62K2XboPC4bzGjo22N2viKbLbPQgenu6Wotz+QC8kzm35/d9IOE2lwV7TlyclghYHPV7NrKZRl3mBkFaFkpHECsDIg2UWC4+KaAmHjMoYHP7MrHPLMpxiLHts4r1ZtiJSoBomFOSo/zN+G6Rh5ZWZIWQteXlR9WYGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784929943; c=relaxed/simple;
	bh=OBU710osUZltRsxO5ihB35hPZFAbv+CdJU5iVW/nNys=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A0eqi4YCyI+dPmcIlKf5GhlPopVp7FKQpkTksf0mL6nWRe4g0pnpjIZ3+FilHDgYfpDe1kpukURzjxm8ZkQUDyCckgghVr19Nzs2Ajx7M7zuarRJUlQH1BoQvoQGPVvzF1GlLCIMTjtaLHCw0soY3LFXSuCu2wKUYQl0bLQpma4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jj0CYan8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jj0CYan8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6421F000E9;
	Fri, 24 Jul 2026 21:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784929941;
	bh=uISh/u7ALVGrl6kfKRrfnLU5U/Mqe8+7Lnx6fMI7IPw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=jj0CYan8BoR/CRXNJBaDlV4sIkyhISMfbjo8FnzwLapz02QWBAsjIJIxwJCgsGlKD
	 /eJMM7HUYvJWZ16s5kor/IurXOuBOvj952jLGQIXgKgBUAuNybu4VfU8IB/CtzUEZF
	 PIah1KyXS4rA31qxe5AfBfKQokWYkjyPCFhvFnJunye0KXqhPio26vb3wfdLUh5XjR
	 M22yL3B65ih5aXFen6gYQycBO9d2AGY76J6NieyDwZNSF1H7wh8XtfX5TqZJ1OuBsS
	 U5bzWNAPSzUUgPdf37OkHk3/8dTTzfgg+PmGo7DxG4Ub8TricUPfMSHZvWOTYic5i6
	 DJ3n34qIttOeg==
From: Srinivas Kandagatla <srini@kernel.org>
To: Amol Maheshwari <amahesh@qti.qualcomm.com>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Eddie Lin <eddie.lin@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260701-fastrpc-cctx-cleanup-v3-1-3a73c2e4ce1a@oss.qualcomm.com>
References: <20260701-fastrpc-cctx-cleanup-v3-1-3a73c2e4ce1a@oss.qualcomm.com>
Subject: Re: [PATCH v3] misc: fastrpc: fix memory leak in
 fastrpc_channel_ctx_free
Message-Id: <178492994036.533095.17096221699937376014.b4-ty@kernel.org>
Date: Fri, 24 Jul 2026 22:52:20 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 01 Jul 2026 19:21:59 -0700, Eddie Lin wrote:
> The 'ctx_idr' is initialized but never destroyed when
> the channel context is freed, leading to a memory leak.
> Add idr_destroy() to properly clean up the IDR resources.
> 
> 

Applied, thanks!

[1/1] misc: fastrpc: fix memory leak in fastrpc_channel_ctx_free
      commit: 7de6fc30fcf26d9096558ce41d58448fb5286f51

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

