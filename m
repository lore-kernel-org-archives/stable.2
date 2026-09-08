Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D53B483BDE;
	Tue,  8 Sep 2026 21:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788902872; cv=none; b=tolatJP7YrYIvDtvxwvqlnfZ4EK27eVQ6f+J//LaPHO++xEpOUXxbMQKHTp1SxbH7emCMYlddafuInXaIidbPHO2kodmjyWUdztCwlUMKxfO07/H/h4nMEQeh7JfF2uO+FPxKFMrwDKNkKPnULskTxxYJqUhGRQnPX0uzw61I6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788902872; c=relaxed/simple;
	bh=nKfl4qroJvlsNG9b/JDeXtvQA6ocWF5QlvNPK3Zjg94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AY/oq+2ijgPq7OwHZdVMHVgtnA6aCqFTNhXfoq7LnSl+YjvmSA1/8WHajzn7Ee0D4wUogg9+xQSOsZA4jUJn1eBveQwv7qs+9mV0uiRy9JmkGoEagkja9UMVDFL0Wf5yA1+BxrDFn1UYkHsLRUMfT6k8Ru1KLalRXXICStNovXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtiU6qAO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtiU6qAO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B14D1F00A3A;
	Tue,  8 Sep 2026 21:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788902870;
	bh=857GXWh5Wp+T+/E/9iEX9gx5IzxzoNleNVwqN+hai+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dtiU6qAOIMB++ZEgT7ArQ8A+1eY9m0aeMRbEECD3xRT2B/ws4In3noMgrNS5nR1KS
	 m4VCI6nzngZOd1tbotVNI1/O/0eRPg1j2dE5zyiNCx+NwsK8xh+ezs9451E2l1tvu3
	 6zdVf2sq/Rgwe6BoM7QyTvF5blVU7jnLDHxD3FW1NXB5FFot+lq5USwP0cYgV5TQx8
	 WK8oCBGkvl3yYSPxysiq8ZRZNcqHyx6Ij7PG2u4vke5Yk1TGZX2dcIIanY+n43yhi+
	 IGOTGtg+1m/6Z2O8tdDC1BD3LzlPWNWpW0fCHuToGYxUI2RTlbMu5JuwDebH6ZUE+E
	 ysT9xDAklx7Og==
From: Yixun Lan <dlan@kernel.org>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guo Ren <guoren@kernel.org>
Cc: Yixun Lan <dlan@kernel.org>,
	devicetree@vger.kernel.org,
	spacemit@lists.linux.dev,
	junhui.liu@pigmoral.tech,
	stable@vger.kernel.org,
	Guodong Xu <docular.xu@gmail.com>
Subject: Re: [PATCH V2] riscv: dts: spacemit: k3: fix IMSIC num-guest-ids
Date: Tue,  8 Sep 2026 21:27:45 +0000
Message-ID: <178890281743.280809.6794567458346046104.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817033038.2286436-1-guoren@kernel.org>
References: <20260817033038.2286436-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 17 Aug 2026 03:30:38 +0000, Guo Ren wrote:
> The initial K3 device tree used generic/placeholder values for the
> IMSIC guest configuration:
> 
>   riscv,num-guest-ids    = <511>;
> 
> According to the SpacemiT K3 User Manual this values is incorrect
> for the X100 cores:
> 
> [...]

Applied, thanks!

[1/1] riscv: dts: spacemit: k3: fix IMSIC num-guest-ids
      https://git.kernel.org/pub/scm/linux/kernel/git/spacemit/linux.git/commit/?id=69f95409f0053f787ad60175944080621a8b7d95

Best regards,
-- 
Yixun Lan <dlan@kernel.org>
