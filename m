Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793186891;
	b=kcs+mB2G/Pg9oUeDeSehXnwrRTT+1ZzpAHiQd2yQrr7+Y8YRmxJd3sVgxtO05pjzhDA2
	 VSMhpSoQrPLXypCn8Ry2bYitT4uALELdqV88C1FbV9KhHwFAIQLhct4GNxMn8+jAy7a9/
	 d+vFhIELqNVEm5OPpCEjZ+s3PmCpSYs5xIIMAwXBLYkl+ZRupep6BomfGXWcBRiomZgIa
	 B7fYvBaPP7TB87Dy872QJlAWbKXznN6oL4tERHsPGP3eBvQeiI68T0E9j8H/t1+XzYqi3
	 heQWxnMmKf7Rxk7C55NSyrBk8VQue3qf+NDafCsbVM90nC/ckZkbcoW97HuBSSx37cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186891;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=vIWVBmt+g+4k3XTPpYXALk3GxorAmmwSHt+9R0Q0bWc=;
	b=LzswfdqhQBvavvYZvU7N9iq4OfDLCJzeKJYY1InKc+bye6Do9m7iVPSluk+6IQjvDNAI
	 0BYAvFYXH0/b/Fg9/w6SS5DysuGKGVURzAE11QpSEywXvTXWCbD1nYcob8lCxm/73xFlQ
	 boW63mMoZ8xCGyu5tkAvAkZuM4zyLkT0+YStL7L0679EZRssq7TvDQcgjM5bO02QhuOXo
	 mUYDHSjElCBRoStKgHKIfZ+zzef/L1o65UFyow+qK1hCRqj6ahQftxQgGucbssXYnavQf
	 yZcVXQ9Qd1vCMuC0lKOFXTJaXwofnOHBaHJQDfw9YdSKpESr0AKjUyRn3MUt7luj0GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kyxoPVXr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90603606A33A;
	Wed, 28 Oct 2026 11:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kyxoPVXr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2869C1F01825;
	Wed, 28 Oct 2026 11:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793186891;
	bh=vIWVBmt+g+4k3XTPpYXALk3GxorAmmwSHt+9R0Q0bWc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=kyxoPVXrHal6AJLrnmAS8yQ5rW8KFQqwsHHOqjCYJOTabiTlR8XkUvUwL3cXALd2A
	 XO6sVZ1UGG9/8zO6FYcpt3cJoiyvmL2UN2At5lXqTgBDcg6cw+MXxUKy16G9Dde/DE
	 c2wS1XAiNoYJVYlqtHOkMNqjn2iMJ156ls9UJfV2uIxmiFjDxOE7PSWxM6eUxSGJJh
	 3pBwGRXEBuqj5VDXtlJ4GgcFS2h0iOIPPJdqmU6tCjsr/PVDpUxAJADtoq7HsrT6HO
	 BbwqJMrdDubx1aXJjKG97Z+73Jtlq0qh2EM+ZNS32wZU50j9t5yEt3Ln6GtJFCGaSx
	 nCbxJ2zbKwHkA==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 6CE9E1FF23E8;
	Wed, 28 Oct 2026 11:28:09 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com, 
 yung-chuan.liao@linux.intel.com, stable@vger.kernel.org, tiwai@suse.com, 
 perex@perex.cz
In-Reply-To: <20261027083840.28813-1-peter.ujfalusi@linux.intel.com>
References: <20261027083840.28813-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH 0/3] ASoC: hdac_hda: Fix module unbind/bind via sysfs
Message-Id: <179310201620.199157.14946158307073154268.b4-ty@b4>
Date: Tue, 27 Oct 2026 11:53:36 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1617; i=broonie@kernel.org;
 h=from:subject:message-id; bh=0gWxUMOc8U+aGgj/FaBpD6Hf/YtiHi0nKmV867VQMfI=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLIe3vH8sG6eBtMl2bhiCZVDgs6/+q1Opu/Ybr5z7+Nzd
 6Pf5fpO7ChlYRDjYpAVU2SJy+J+WV/yeg3fwYVtMHNYmUCGMHBxCsBEOs8y/BXuWS/L5bXt2rqJ
 rc1t+gsfeNhYH5D5y9W93eQp97n7014wMvw12d9dFe0xs0RCmv/4N+PKjgPfN5QK6gv+U51z5pF
 oPDcA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 27 Oct 2026 10:38:37 +0200, Peter Ujfalusi wrote:
> ASoC: hdac_hda: Fix module unbind/bind via sysfs
> 
> Hi,
> 
> While looking at the reconfig lockup reported in
> https://bugzilla.kernel.org/show_bug.cgi?id=222182
> I checked whether the same can be done by unbinding and binding the HDA
> codec driver via sysfs:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/3] ASoC: hdac_hda: Allocate the private data at codec driver bind
      https://git.kernel.org/broonie/sound/c/7d357eae973a
[2/3] ASoC: hdac_hda: Restore the codec device type on unbind
      https://git.kernel.org/broonie/sound/c/08a44bde821d
[3/3] ASoC: hdac_hda: Balance the runtime PM disable in codec remove
      https://git.kernel.org/broonie/sound/c/f26c0d5f91d9

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

