Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40082417BCA;
	Tue,  4 Aug 2026 18:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785868593; cv=none; b=UGBLeyP0j+u8ZjG0/r1XZ7BujLMGgX3AH6sqPYm+/zAakeuUcxgUhBodAUW9TdRl2zfjy5DcXFhGa2XcwcqpGlCulfpQ/PMOeGwEbPKUAUOqfEThmWneRHU4Mis75ZS1fRKNojEcFSKV0JvD4CKDBRsyTGnSdZgeq4v2NLddOgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785868593; c=relaxed/simple;
	bh=k0RUbAfmtJOPPe1nwm6bWd+HuBRuvJIE/lXtvoCHCg8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KCWQOXu2LjnlNOcolwdmc0agCI7/Sa/Wc9Dun7Hv/7KR1sFKOwi4GnXHtcQ4KcPOk1e8+xdZooEAKoThTX7MtD5pX3bxtDYH1Uss4A36PU1QmpJEN9CO8opb7WleLCLQ+6Wqtzhv9NoF17+qw8EllM5Zulayxa5AXUjWg7tdeX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eq1c7yd2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eq1c7yd2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2701F00A3A;
	Tue,  4 Aug 2026 18:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785868591;
	bh=0X8IhTHvQpkzvsUwD/aLL8e80jF3EDnUkpv/vfqz7YA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=eq1c7yd2TrJ65ThIcsy6Jdz+QfQyVijiSu0rM22lDvp/4lQLP1UfSXwO+F+tevQ2i
	 ogn2eG43aZXz1Tp7k+9YHYdjAJTGK1KCpNA1gIK7aGfoaKHkeJL0hsgkr9WeDQQ9x9
	 TAUQTL0GpudKl4vdoNEJJCol4KnWlFKgdS9o5TGYgHUpbknDlr0wsxbLZiT8KR1acB
	 5pZpiQz2DAQjA5UQHtgRmZ6EHf/086I3rL1032yGZ8nKGzlox7K/t/Wvf15i1fHBmT
	 BgKuRqGjCV+fHalb4uW2NLqxAqgTu2hMsNyTCH+pisMFvKpa3+E3wl03aXDG4PVm9r
	 1KrswEXfwdfew==
From: Mark Brown <broonie@kernel.org>
To: jonas.gorski@gmail.com, Can Peng <pengcan@kylinos.cn>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260804071831.860784-1-pengcan@kylinos.cn>
References: <20260804071831.860784-1-pengcan@kylinos.cn>
Subject: Re: [PATCH] spi: bcm63xx: disable clock on resume failure
Message-Id: <178586850216.111355.10824926560684951483.b4-ty@b4>
Date: Tue, 04 Aug 2026 19:35:02 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1101; i=broonie@kernel.org;
 h=from:subject:message-id; bh=k0RUbAfmtJOPPe1nwm6bWd+HuBRuvJIE/lXtvoCHCg8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqcjEtSr2RDwV1XYfUiGEk+YUyKNtn61JkqhUGD
 HOSe+TA02WJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCanIxLQAKCRAk1otyXVSH
 0AIOB/0foPZA9cxx8Wi1ehLVSeaGIIrXE4czr4EMyc9xQJYEBXJNDpHQ8XB3fJ8Ea4idMaVQG0c
 pNHrOSM4DohETx2FFj3C5tuFgg6ZeqTyLA9zmb6FJQ1ed/LYc4YOVC16aBP8GvFjlQfpSNQd4Du
 Ie8rJrUEH0p5i5B6ptKVBA09VhsYhg8UyEcV9th7oPkw0WbRzytYLbATDo4Vt7q6hwUVBX9pXs7
 GXX8Ww/vB55agf3NfKpmWmjgWuqtFTfJHhAuLEOX7AkLhy2QCc5VBFY7h+4DQzMzinnxb4Y9Lhd
 Cs42ykFXhw5SSPdY6hJutmjwlcTssekgRhffQdjOosZJ/IEV
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 04 Aug 2026 15:18:31 +0800, Can Peng wrote:
> spi: bcm63xx: disable clock on resume failure

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/1] spi: bcm63xx: disable clock on resume failure
      https://git.kernel.org/broonie/misc/c/2b62c2c134fa

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

