Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624856;
	b=zf2PqcfLr9Lhel19/SQG/YEl80FooU/vM9KyHAbDWoQwR3BIwYx1QxnUYC97irOyCycz
	 aFANol+yfTx0AVcp9B2Uw0MjdtvnM13ULxRIdCGGoT4GN0SDvgQ/TZu0O06EesNnQXFCB
	 jGPmbYV+JdiSXb5pKLIfk6vR16bj8V50jEfEAJ+1Ros38Df2lJW3AI4k6RBNHC+ACMw7d
	 jtoVF67drzvYIw6StLlAgJOlavNwa+DwkNJRLDY757cEvfHZB+AIiv4ewcLhp2d2vLWrH
	 Qzg6j+fOtFyzjwGK5sufY/J2cUXAtxzuE/RYxWyCjJUhAZwZTjq27JD4pzpgsmyl63w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624856;
	h=Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:
	 From:To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=D6KrOaTLNvlRqd0aclSX+7hpHIhRvkGmOOdaa4m06XY=;
	b=oFUbm+LxQ+6Ukf3TyIr704r1HNibpfxL54rwJ6yWJxTrLPoVMf2ptMrH9OJ9WkElo1dk
	 GARgCiDYxEy2aFkxYUX02ewvpEpNgmRc1eKYMGvm6/2tX8kbKB/bHhBOZW7G97RrGW0TT
	 cXB6fUL/vOGfBFIKKyYvIC3OUDr7aB/bThMlfpf+IsiYno+JZ2plOUsXTKVPofdeDoDRK
	 1usjsja1YnGottlkZlynvs+zZ6nEewb11Rcw9QsAM2wCK0znoVeyN+CuXDXj8MRB338bC
	 ZG99UUbsrKvetQjoLt0Y8lZTZK4y7nKq42bmnil2C+GYEMVnS6FAMReBn6Yzs2Qk4pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD22606A31E;
	Wed, 25 Nov 2026 16:40:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB051F000D3;
	Wed, 25 Nov 2026 16:40:51 +0000 (UTC)
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
Subject: Re: [PATCH v7 03/14] PCI: rzg3s-host: Don't mix goto-based
 unwinding and cleanup helpers
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
 robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de, 
 geert+renesas@glider.be, magnus.damm@gmail.com, claudiu.beznea@tuxon.dev, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org
In-Reply-To: <20261019065025.2146539-4-claudiu.beznea@kernel.org>
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
 <20261019065025.2146539-4-claudiu.beznea@kernel.org>
Date: Wed, 25 Nov 2026 22:10:46 +0530
Message-Id: <179562484639.5580.736218629244331876.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=650;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=/ppm36g8Hvf8+xIWiQuysux8dzhzQcWlGoQ7E6h4NrM=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBrBw+SbB/iYDBkFNnXhavwt0C/gX0ErNMa3Aujc
 bLvStrYgqSJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCawcPkgAKCRBVnxHm/pHO
 9TZqCACM3Ij2O76ufYmuGLZh6Xt7wNO8G9iggKy1aTvvDQ+40DogVPmezGKNfeOdPdW0fbbrLCW
 bsqb+XY2Aj8/3+uYaDnMiQXpXI2RqJCO62GNdfYV9nRzrnZvrlktSQb2mnV3MlYYWKhu3VwA5xl
 FZ0+dz0L0o6cxtolj23rvWqjR24ZXBFYsv6lR6/a3/j87B8zGyxIJIOuIeCvAjK7J9IX/nUShoI
 0Scfj9c9k04DhU2307c7qRp3sfRKxnpjHoaYP+nzIKgMU1NvkliOUbfz9Jdy20UBjMogcTZgjed
 0vWc460AovIEHn1X8FCCP4YZkpMvUp2mkaUvWl9x4RBwxTM1
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-10-19 09:50 +0300, Claudiu Beznea wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> rzg3s_pcie_probe() releases the sysc_np OF node through the
> __free(device_node) annotation, while the rest of the function uses
> goto-based unwinding. According to cleanup.h, the two styles should
> not be mixed within a function, as this makes the ownership semantics
> hard to follow. Drop the annotation and call of_node_put() explicitly
> on the exit paths instead.
> 
> Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
> Cc: stable@vger.kernel.org

Is this really a stable candidate?

- Mani


