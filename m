Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77213A7F49;
	Tue, 29 Sep 2026 07:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790667796; cv=none; b=sD1N9fGtNWeLxRCOqguURX6cIsHrrP2KuHkWZquz7TYcBwzvIKHGCQVEpDDknKd2rC/AvGCp2idVxjrV08TNtTCKzS76D2mYJIQGNrvqpbrOJU10Pi/dxmMtkk4/jWEtkm4LHVnlYAwjCuJDiAZqcTWi3KfXYZjraw51+DN/1Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790667796; c=relaxed/simple;
	bh=6a9MaQRoVIhlWq0gnCGHhRkiZ3MdL6iE5XqB35pLzxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7qaNakvCXBPzdC+M7Kk/n57rK5ZmXQg6zE6hB3ZZ+Cj3Bcfwf1k3SspKflMXCAigcJZvhAhBBKL2GFrQERaKnqYggIteGvdm0vc3SEH52fVVgf9WFxBTsbSpiALeAfUN0snimQaSondM5yupbD4RF0wOp5gicnGrjg/ZZ2KMeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgUpGNhR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgUpGNhR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7DB1F00893;
	Tue, 29 Sep 2026 07:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790667795;
	bh=2AQZlRf6FiaJItjF/uilrmdoGec1thZc+JcVpZC4iDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OgUpGNhRlWTt2AmHVcVgoDq4ae6hlmFlOlKxX4MoKNK+Vmv6ZhZajVQQal2WF+5uN
	 tTHfGRb1B5H4eCYtnm73efUZDs3HIPAp4SmA3jXTDnjt5/8/2/u1QAimScMRz621xj
	 3jTYGu+NZYY3zr209x3e7rG+e/OPFLzZ5Tf3czXkss/i02hbWU+dtQWk8JOqXp7cm5
	 ssa2/NmacMEkq3btnDOVHjwHTGq47tzICLbP8F84OMZRmuqNBOBkVqgvPxrTc17l9K
	 F/QkO2euyuUFobJYlF0LkHvrpLAgRo6SrpHogjpLwNyjAT7eSwe5TsbxtscEUcwEuS
	 +YSSTgJT10PMA==
Date: Tue, 29 Sep 2026 09:43:11 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: David Heidelberg <david@ixit.cz>
Cc: Dzmitry Sankouski <dsankouski@gmail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <jesszhan0024@gmail.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Petr Vorel <petr.vorel@gmail.com>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 03/11] drm/panel: s6e3ha8: Really assert reset on the
 failure
Message-ID: <20260929-electric-unnatural-gorilla-db20de@quoll>
References: <20260924-crosshatch-panel-v2-0-08d5c7bf72fc@ixit.cz>
 <20260924-crosshatch-panel-v2-3-08d5c7bf72fc@ixit.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260924-crosshatch-panel-v2-3-08d5c7bf72fc@ixit.cz>

On Thu, Sep 24, 2026 at 04:01:31PM +0200, David Heidelberg wrote:
> Due to incorrect implementation 0 == asserted, thus when driver fails it
> needs to assert reset.
> 
> Minimal fix for stable; the polarity convention is corrected properly
> later in this series.

We do not do fixes for stable. We do development which MAKES sense. If
you change this line here and in the next commit you change it again,
then this dance makes NO SENSE.

Fix it properly.

Backports to stable are something completely different than mainline.

NAK

Best regards,
Krzysztof

