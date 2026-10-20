Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489959;
	b=C3qAUGB9tZ8OzgfibpYo5zeToheSZP1YJ/SXuaNCjEGuiD/9z4qpyWRdUYF00wbwIIM8
	 gv8S/ojJSWqkpeOOpYLw3vtM89D81HzAtbXhNqzoPVM3pO8DUWjGW4Q2yWLvrGzlqxVEV
	 PpUsr91dChiUH0s+6DJ+yh0bTwxHGtyQRNTwhiXmBdzx3l3pIT5JpwXROuunCSCEnvUNt
	 TgKRa8taWSMjSae7sSX4yx4vGKqOkNCnVWWVUJE/ImwAfhGWmxufCWgieW64ZkyP0s/lK
	 CUS/Ekct/WlsvuHUrvOajNFjVzR8V87CewN89lSBHpahN0V1hAVkwSkRa7QcxMuIhXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489959;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=gQ2SwmVXUkAUiM9XFThemWfYw0T4dJSWAXZ4yepXyAM=;
	b=ePKcqADXZJGzq7YF4MZMF4NuxHkG/Zt46EcnA30kcmYaCZQAqVqhZ7ET75LVmGjzhuT2
	 lRt87KrWFmGW7EStJHyuS6M3L0xWxm8ijrKgWoq9NbEV0nQWf9dcdPzqzEquk1Qz3rYUl
	 0wOrlp2mdMiUc0cXdyuoWegiy9raB0HdyIKRe3VHJ/KWlvW6wtYwzx4stVnB4bL3sJh4p
	 bImxAXsCqDdOvU+fQ0KJ9/LN0zzqbjrYhNOtvW00yBfvZ4PpkhRYBdxwrec7HoGdck8NG
	 uiiqPnjGspKWmxgb6SwiAVu0FtcxzvDqdTCnp0ZPA7Sf1/RVgx6JZKPb4dygxbahpmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XrnqkHe4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF682606A31D;
	Tue, 20 Oct 2026 09:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XrnqkHe4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC39F1F000C4;
	Tue, 20 Oct 2026 09:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792489958;
	bh=gQ2SwmVXUkAUiM9XFThemWfYw0T4dJSWAXZ4yepXyAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XrnqkHe4uJYsKtQ9X8rF4PEAzOicSm3Mz/s8Rvk8PEjj+zJw07rHCGDEmVBaSruUx
	 vFrSfGPWvy+oNjXImFA62m1qgYS70pJXFH4iQ3Ec9pXWk43aXu0Y+CvNjFrUMALkNC
	 64oq5K7Y5Anz+SyxaWFpKP0NFdrLPvMeOjeaPScRk+VGHPE2DjWt/o8JVXLbLy8anV
	 gTF6bmDWc1ZeZCSQphYyibI2lPy6VbPfFvcPYMn8VIW9k7ZeZF2Cr9ddajpHC8bVIV
	 pZSg+aVDdcc8ejQvGBLLvMZPtPgeaaY8VbWHt9ErWutVJn4+T1erRSNFsN4HF94WZ9
	 oB6MpK2nhCRfg==
Date: Tue, 20 Oct 2026 10:52:32 +0100
From: Lee Jones <lee@kernel.org>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>,
	"pavel@kernel.org" <pavel@kernel.org>,
	"kees@kernel.org" <kees@kernel.org>,
	"kabel@kernel.org" <kabel@kernel.org>,
	"ansuelsmth@gmail.com" <ansuelsmth@gmail.com>,
	"mike.marciniszyn@gmail.com" <mike.marciniszyn@gmail.com>,
	"linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/4] leds: trigger: netdev: Put netdev on activate
 error path
Message-ID: <20261020095232.GD1206986@google.com>
References: <20261001131206.2513248-1-alexander.sverdlin@siemens.com>
 <20261001131206.2513248-2-alexander.sverdlin@siemens.com>
 <179198456306.839288.14631216021466477145@kernel.org>
 <cd3b43e958eeb97af33c23cfa6c49b7abceacfea.camel@siemens.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd3b43e958eeb97af33c23cfa6c49b7abceacfea.camel@siemens.com>

On Tue, 20 Oct 2026, Sverdlin, Alexander wrote:

> Hi Lee!
> 
> On Thu, 2026-10-15 at 15:52 +0100, Lee Jones wrote:
> > > When hw control is active, set_device_name() takes a reference on the
> > > netdev via dev_get_by_name(). The register_netdevice_notifier() failure
> > > path frees trigger_data without dropping it, leaking the netdev.
> > > 
> > > Cc: stable@vger.kernel.org
> > > Closes: https://lore.kernel.org/all/20260914140045.B8F4C1F000FF@smtp.kernel.org/
> > > Fixes: 0316cc5629d1 ("leds: trigger: netdev: init mode if hw control already active")
> > > Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> > > ---
> > > Changelog:
> > > v3:
> > > - introduced unset_device_name() as a counterpart of set_device_name()
> > > 
> > >   drivers/leds/trigger/ledtrig-netdev.c | 13 +++++++++++--
> > >   1 file changed, 11 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
> > > index 5b0132484594c..e2a6c95a0dc97 100644
> > > --- a/drivers/leds/trigger/ledtrig-netdev.c
> > > +++ b/drivers/leds/trigger/ledtrig-netdev.c
> > > @@ -324,6 +324,13 @@ static int set_device_name(struct led_netdev_data *trigger_data,
> > >   	return 0;
> > >   }
> > > 
> > > +static void unset_device_name(struct led_netdev_data *trigger_data)
> > > +{
> > > +	dev_put(trigger_data->net_dev);
> > > +	trigger_data->net_dev = NULL;
> > > +	trigger_data->device_name[0] = 0;
> > > +}
> > 
> > Given that both callers immediately 'kfree(trigger_data)' after calling
> > this, why bother clearing these at all?  Wouldn't calling 'dev_put()'
> > directly in 'netdev_trig_activate()' be simpler than introducing a
> > helper here?
> 
> I agree on all points!
> The v2 was indeed simpler [1].
> unset_device_name() was proposed by Andrew [2], but maybe I went to far
> clearing things which are not required to be cleared actually.
> 
> Shall we agree on v2 of this patch as it was initially published, or shall
> I just drop the redundant zeroing from unset_device_name() and leave it
> just calling single dev_put() for now?
> 
> [1] https://lore.kernel.org/all/20260921093249.3481413-2-alexander.sverdlin@siemens.com/
> [2] https://lore.kernel.org/all/13e58137-2104-4ba4-9d41-e30ba5dfb367@lunn.ch/

How many call-sites are there, and how many lines would
unset_device_name() actually save?

I think you are free to use your common sense.  Don't free / zero
anything that you don't need to, and if it makes sense to move the
clean-up to unset_device_name() do it, if not, don't.

=:-)

> > >   static ssize_t device_name_store(struct device *dev,
> > >   				 struct device_attribute *attr, const char *buf,
> > >   				 size_t size)
> > > @@ -776,8 +783,10 @@ static int netdev_trig_activate(struct led_classdev *led_cdev)
> > >   	led_set_trigger_data(led_cdev, trigger_data);
> > > 
> > >   	rc = register_netdevice_notifier(&trigger_data->notifier);
> > > -	if (rc)
> > > +	if (rc) {
> > > +		unset_device_name(trigger_data);
> > >   		kfree(trigger_data);
> > > +	}
> > > 
> > >   	return rc;
> > >   }
> > > @@ -790,7 +799,7 @@ static void netdev_trig_deactivate(struct led_classdev *led_cdev)
> > > 
> > >   	cancel_delayed_work_sync(&trigger_data->work);
> > > 
> > > -	dev_put(trigger_data->net_dev);
> > > +	unset_device_name(trigger_data);
> > > 
> > >   	kfree(trigger_data);
> > >   }
> 
> -- 
> Alexander Sverdlin
> Siemens AG
> www.siemens.com

-- 
Lee Jones
