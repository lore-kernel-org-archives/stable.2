Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637064;
	b=c+vj+Qz+Tfe97sHVAUk5HESmNl0MkSpyXqQ5GZ9LtsdyrrMtXSwf7GhfUdI+ljiIjrAZ
	 GcysFvWA8yKLIrkVZdsaOxEq+HsSf+n+uOlZKjBQHA3+Adrvd4Yhm22bpuiwbXy3mCjjX
	 5qJBnWRpP2/NBzbjHCEC/yZ7TBqQmio3RA5+izRm8SKhwTnnIPbOZY8cKzPeke5vu2Xd8
	 VW0atRuqQx2miMJ56qNurtVQW/89BwQEzvynaxeMTQSG7ZN+kQx/G+trymAOea6n3N0Iv
	 0tJxHr9ftsafCXVXwrHMAHUbcn2h/r8eXK9cLnb2ax1o2aOCk5wzig7XoH+4q0ezGTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637064;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:X-Patch-Reply:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=SM+L4BtZ938Hgq4xOvd1JY347Fs5FQDgq/3V0Ixba/8=;
	b=SygohA7nMhEVJ9KxG38kEevgBnG6Di8Dzp+fTbQTgXkOvju11cWWXozBTTnNWsV8GE5q
	 IPULLvfx136lAD1fwATlZ7dOzccekj8UXto79ZTknfnqVST+FdbSefptID1cAeE/zA4jt
	 8UfOi51w5rZy+lX7OxuqTNoSnbza0xAjEK1NED5NwzECBxuVzzrSBZk7Sh9k5GD9UHiNO
	 5B/Y/CZaNJyDMBtkDIaWGnpgNwdVHIklRyPUHZ1VPfQ+0W67aQg+msPSpS/IW5fhSCE9L
	 F00Id4I3F8zAU+FE3Snwp49JZWI/p4Scf2VeaXekTo9cCDfBdYjXDta5+CbvkMToCtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NRLlf3VL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD15606B0D0;
	Mon,  2 Nov 2026 16:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NRLlf3VL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCED01F00A17;
	Mon,  2 Nov 2026 16:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793637063;
	bh=SM+L4BtZ938Hgq4xOvd1JY347Fs5FQDgq/3V0Ixba/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NRLlf3VLUbbvICwrz1RnO2CKpin5JWuQitAqYAIClfhAB0AegadYW31aftpt9Ttqw
	 9OYQal7Lj2dMSd7PLhpnAF6C04bd6cfq1Cg7jeE8KAEo6XAngtp8lut15TRxijsUBL
	 FrE8nsNQIKW0bDNiBtIZQR2Na4LT+JT2H0uYyHKWXdWaJvbeCokbuz56os+OqwsKnt
	 lQJBDQIfIsphTPkhXv4oC7hgfgCZ9XKEdgndtNFYVW7+nR4OmtMqBiPHIFG+qmwE4K
	 Fqs8IaCL49bYWxFc09fAdmbImZQCuf41NhaPLPlyugs0lcZpIo+x81xMoNedFJ68vZ
	 /62k15wutL6dA==
From: Danilo Krummrich <dakr@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH] driver core: platform: fix fwnode leak on registration failure
Date: Mon,  2 Nov 2026 17:30:54 +0100
Message-ID: <20261102163054.3147841-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102082822.1275425-1-johan@kernel.org>
References: <20261102082822.1275425-1-johan@kernel.org>
X-Patch-Reply: applied
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

On Mon,  2 Nov 2026 09:28:22 +0100, Johan Hovold wrote:
> [PATCH] driver core: platform: fix fwnode leak on registration failure

Applied, thanks!

  Branch: driver-core-testing
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/1] driver core: platform: fix fwnode leak on registration failure
      commit: 7b4c25424cf5

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is in the driver-core-testing branch and will be promoted to
driver-core-next after validation.
