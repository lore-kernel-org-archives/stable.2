Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEF43CA481
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 05:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790658896; cv=pass; b=FEZHTq0BiJkT1nSSqs/4oNZBxyjIKFjWE/5GESpENTFf5vflSsCVkAi7keZ/w/+S/OfuctmcLx/bxXhL59ZxzfSoCvllW43F0OwlCDmIQjEMr+tpnLaY/bZ8sORYz5cbccqnFHQ3NxXJxKx1eE3T2xdbwRRJr5SUUT6aK+DlHV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790658896; c=relaxed/simple;
	bh=rA0s4JspSo7O0tH/iLy8kquoeGBF9re5xp9O8FBHWkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YshxKygi3EECG3sssc5xDxkGVfmdYmMGAUktzbV0KDCOJPlioHfucdC0qeNuf8wEyFdsZjTtPVbmIBuw/ZNet54NJbomq+vwl1Yl0D+LUGZy3WnrsMVuacjT+/bLHe+08zkgLTU6yFHwywHpQ8xFAMh8zo9ZlfKeYLM005C0mqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qbCGE1h/; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qbCGE1h/"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39666bed444so401822a91.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 22:14:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790658894; cv=none;
        d=google.com; s=arc-20260327;
        b=O8KTRxvhOOhg02Mc98mC8X5Ab89ymcIWKQYg1zdtMM4IIC6JrGW9aV+Nie2jUoT6ri
         qwKVzdEVa4ltRWrp4OHZESN0syF7C+5BNAhoVOZpqtNNgOFfHSUrCGxLDlJF7cJ/vHlN
         Rc80bhKnZ4Le0CY47eRDHE9e8JeGwxZT89GFoPTba4ug4+/lYCzPv7Qx7DAKJgxHSZJO
         tXGEsMfBGYrD6xSPIsqADxfN7AewAsgx5udMYGTHVm/2AqNtOg/jgEMRxe5e0D9NVt+8
         Fk3jHYdxU8aTmviGiwCtrLkecVtXxC5DXmOOq+bVkvmZ17BbT6jqv4yB5KGrEG7xKuu4
         Y+6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rA0s4JspSo7O0tH/iLy8kquoeGBF9re5xp9O8FBHWkw=;
        fh=sRFoZQs1RkXzzXz3WguIjRiS0v3+kP4YQZKXzjY6H8g=;
        b=SgEVBoJuf9uML+Kq4KVn657KAgpWCT4YnNF9awphGjvlgNSdnWOk/G1c2wybPgThrP
         IxL8/Z8o7H+XGnrfK2iZEnduMc96p2n2uGZizvOrTUz6Ibzs7NGfeXwUK2riLEbuxEAN
         oBnceW3AGZf6N0n4CN/Z66b/PyOWPOIYtX9rQn05YzCmxpX9sWxqUUtaaa66kDF2nErD
         l0tXZy6SxpFJADfs9nSKdkyE+riLkkjHLGJkqIRrzD+VhvSJm+fFhHJc8+BFdERf/XG7
         v9BzYoDK0goE6bXScayTpAhsAP4eZgltZx8Rt2QszHXDwo/Ajw5LR+ioQwG21FKUnfRA
         GPmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790658894; x=1791263694; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rA0s4JspSo7O0tH/iLy8kquoeGBF9re5xp9O8FBHWkw=;
        b=qbCGE1h/AxgXTiElVk+budX0XOlYtXo5APy05HebjUXTfUJz0Rxb5ThsdkjToptYwJ
         j38ewruVYgReZRGMOFVYeWrYRZ4rvAQAOkRHlW82C84Xx8p7BrpaOB2EMlc+rFeADYiY
         61kKw+HlpYrGCdIJPJz7ims645dNPYzp9f3of5MMPEYWZBLIDJmmdE0Zrp9hWB06JDEK
         wiZhs+URDBY+rxIhb4ZCx1nel1fCYyy+7Tb2u0pgjY6X/ooFZ/lMUGT4MplzfB3U41fQ
         Zkh4mUi0GNHOu2MoNv6PlvtpMxKbjlxP0WyA2GAJ/n1FEczMuFCkcXIe12WpUtQc0IX+
         FWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790658894; x=1791263694;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rA0s4JspSo7O0tH/iLy8kquoeGBF9re5xp9O8FBHWkw=;
        b=hqmzK1EbZ9+C8C30Xug8O3f7zeiOYPNlh86QVtBeW34N/wBBEZuK+GyxINPKHmCmB5
         sJ9f1ir9v+J6zKBv8d8YP1ArsvZf++slR9hEWwNg1DlvxLbHh0s9nPw5IZ0voQ+/34x8
         Jjauok01xjSs/rapIWzBZCEyqUYygTijveEvRGClKgtEq4yIpK+tVQI2WXv4RbGSUrP2
         E5ME2TjaW94ffVx3vQT89OeNworW/nqZqiZI26nvVToi7fib+qoLz1wf3dTEN7x6uVVw
         3xaq4Zv9owp3IN5EdxkZIB4IDmuxeclyfm/ZgvrtJaEyx5+6zb4h41sXnba7LbmFpVa/
         o+yw==
X-Gm-Message-State: AFuF++lESxc9HpcT7XypMDGhyGWXYoiaUhVE2e5CeBsQadKIaU/sDFOd
	eAhCv/SjJFnZKyi614bY6XcjcvQgEVZWNLF0XmUJGnJbtH/gQ+vjzDCG9Xw6pXaAq+SsOr4sIfO
	Ec1c/0nMAl5k0rx5zh6RyweaB7OkR1Q8=
X-Gm-Gg: AYBFou333tR7RCo31/og4z6Iam7SPx/ZQeiSWRCVMFJMIp06pTo1iM0QhxOXdIswXpy
	wLlApnOqgDFAGM8qc2xf4/ofATDxxgUhQHbL74J3iVxA00Rmy4adzkClUgDQ6K30Btt4aL+Ttnt
	06CxE2QreZFMvlrBd29i+JCYYerpWae82+HT1FCtgokdIhv0asISUVGBfNlw+xyJtW2ftvPDxlt
	Ql23Cu5/myQQw95/L302ldm8uR1f3jA+dOGFfDQPXGR5/YLYiR5428SCulsZAYe+zpoW4KbB8Mv
	oNjFgqCi8OL4QZ8D+fm/CfBZ7JAI7EKnkVVUl0AkyHjdj3Vawzxu6r3RpDsmuZNlUjBOvLjX+j8
	KExXwkgoO7IwopVtbvbLQXNOMuqhcPUMjM8u9M8QCEXtFNCsofQT1fnuYqc2VHsa0iG9rc8sNtX
	UNfUo+e4esv7CjB6SEVnlpYJR5+Rux1eUvc9jFLymFu2BJSnUHJFI=
X-Received: by 2002:a17:902:e542:b0:2d6:3c1a:85ef with SMTP id
 d9443c01a7336-2df7dfc93c6mr186502575ad.4.1790658894247; Mon, 28 Sep 2026
 22:14:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928104855.205416-1-ojeda@kernel.org> <2026-09-28-2-daily-reply-0004-re-rust-phy-revert-6-18-left-to-greg@kernel.org>
In-Reply-To: <2026-09-28-2-daily-reply-0004-re-rust-phy-revert-6-18-left-to-greg@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 29 Sep 2026 07:14:40 +0200
X-Gm-Features: AclHuK8OLp4Qw9rnMeQ6sa1AV9K7Db5QHrFmGwc7b6ODADe6Qzq6lZi75NtugY0
Message-ID: <CANiq72nM2+vHeiB3aHBHJfigEm75UYoNEMxX4dmdsRqw23LLHg@mail.gmail.com>
Subject: Re: [PATCH 6.18.y 1/2] Revert "rust: net: phy: fix off-by-one bit
 positions in device status accessors"
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Chunfeng Song <springbreeze@stu.pku.edu.cn>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 12:39=E2=80=AFAM Sasha Levin <sashal@kernel.org> wr=
ote:
>
> One fix for when it's applied: the SHA above is the stable-rc one. The
> commit in v6.18.54 is f22d349940cb ("rust: net: phy: fix off-by-one bit
> positions in device status accessors").

Ah, right, sorry about that. f22d349940cb is indeed the correct one.

By the way, adding Chunfeng's tag from the other review thread:

Acked-by: Chunfeng Song <springbreeze@stu.pku.edu.cn>

Cheers,
Miguel
