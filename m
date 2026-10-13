Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74F4518154;
	Thu, 15 Oct 2026 10:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792060633; cv=none; b=ptBH8hYilohMCTBDvFQjmiiLehXGSOeKbIpOuAk9sO+ZfoL8CSOWUV/a4VQB0nrV1JF72Ggodq2qwRa9XbDmE3lf9P5AO6A7O1Ibxcm1lngXbFdjA1NJQula4u5dnW0cSgybYkUylSbGslPoUQQgpHu0HDL1Zucw3j29RaTzhog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792060633; c=relaxed/simple;
	bh=Wnh+yTn5VRy80ooHJ0Y7kTfmQJ5mxLAND5fcKjWoTyg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=revlSeV/umH1orhmxjIcz9GErBiAzin1uyp0nRoAKoRHsELoCDZM6L8hfdi1rEelcRyUocVmyCxlbk0FzKpW4Q+rdcXu9mRNwha9WCC4BZMcT+B6Sm07WHPxS2yYQgcp/lFdB7+A9QLulJUiDBwyIqxjj3kPfriAZ4tPShE05g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBoXkmcU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBoXkmcU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C9C1F000C4;
	Thu, 15 Oct 2026 10:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792060632;
	bh=SdEwhG5OKUH7Q2rjmi2sUS/ilNjd+DIPkUBQAZWnV/o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=MBoXkmcUcYZPsdPqkss45qaOGT+Qaaj1gmN3mfW5IeHSoGGAECQ8tVLtdqs/u/sh8
	 I7bypE/kc82IK7H+E1uR7BxOzOsCXk+9m/CiTsZ3rQ4O8Q9oDqK5yvBYryI6QzONb9
	 5eYYXZOsZVumxOF/i81zXhq0TZ5uwzTtDVQHRrtyLiTcqLuwISpHqxQcnCoL5Rq4L/
	 s1UnQxKOxDx1Vym8dYryGEWRtVde6fU+fDJIDhoM+kVlYXQbcsty/beBnasFOvtbSN
	 E8DBXem7kK6NWjGo5QUekSDyfPlQAbxfSsWZHBf4VxPwu26eZUlMYzx/nwjdCcBOt1
	 BhQlpg1OntERQ==
From: Mark Brown <broonie@kernel.org>
To: Weibin Liu <liuwb@xiaopeng.com>
Cc: wentong.wu@intel.com, lixu.zhang@intel.com, 
 sakari.ailus@linux.intel.com, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261013031717.3933277-1-liuwb@xiaopeng.com>
References: <20261013031717.3933277-1-liuwb@xiaopeng.com>
Subject: Re: [PATCH v2] spi: ljca: validate the response length before
 copying the data
Message-Id: <179192081341.1606900.18392588969047801645.b4-ty@b4>
Date: Tue, 13 Oct 2026 20:46:53 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev

On Tue, 13 Oct 2026 11:17:17 +0800, Weibin Liu wrote:
> spi: ljca: validate the response length before copying the data

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: ljca: validate the response length before copying the data
      https://git.kernel.org/broonie/spi/c/0fe4573c822c

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

